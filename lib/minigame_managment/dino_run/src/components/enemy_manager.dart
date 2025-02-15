import 'dart:math';

import 'package:flame/components.dart';

import 'package:mimix_app/minigame_managment/dino_run/src/config.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/dino_run.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/components/enemy.dart';


class EnemyManager extends Component with HasGameReference<DinoRun> {

  final List<EnemyData> _data = [];

  final Random _random = Random();

  // spawn time
  double spawnTime = 3.0;
  final double spawnTimeReduction = 0.025;
  Timer _timer = Timer(3, repeat: true);

  // velocity of enemies
  double speedXScorpio = 90;
  double speedXVulture = 110;
  double speedXHyena = 130;

  // each 3 seconds spawn a random enemy
  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  int deLucaCounter = 0;

  void spawnRandomEnemy() {

    // increment deLucaCounter
    deLucaCounter += 1;

    final randomIndex = _random.nextInt(_data.length - 1);
    var enemyData = _data.elementAt(randomIndex);

    if (deLucaCounter > 5) {
      enemyData = _data.elementAt(_data.length - 1);
      deLucaCounter = 0;
    }

    switch(enemyData.name){
      case 'scorpio': enemyData.speedX = speedXScorpio;
      case 'vulture': enemyData.speedX = speedXVulture;
      case 'hyena' : enemyData.speedX = speedXHyena;
    }

    final enemy = Enemy(enemyData);

    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      game.virtualSize.x + 32, // da destra verso sx
      game.virtualSize.y - 12, // da basso verso l'alto
    );

    // random y position for 'vulture' enemy and 'deLuca'
    if (enemyData.canFly) {
      final newHeight = _random.nextDouble() * 2 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;
    }

    enemy.opacity = 0.0;

    if (enemyData.name != 'deLuca') {
      enemy.size = Vector2.all(60);
    }

    if (enemyData.name == 'deLuca') {
      enemy.size = Vector2.all(90);
    }

    game.world.add(enemy);


    if (spawnTime > 1.5) {
      spawnTime -= spawnTimeReduction;
      _timer.stop();
      _timer = Timer(spawnTime, repeat: true, onTick: spawnRandomEnemy);
      _timer.start();
    }

  }

  // called after onLoad()
  @override
  void onMount() {
    if (isMounted) {
      removeFromParent();
    }

    if (_data.isEmpty) {
      _data.addAll([
        EnemyData(
          image: game.images.fromCache(ImageConstants.scorpio),
          nFrames: 4,
          stepTime: 0.1,
          textureSize: Vector2(48,48),
          speedX: 90,
          canFly: false,
          name: 'scorpio'
        ),
        EnemyData(
          image: game.images.fromCache(ImageConstants.vulture),
          nFrames: 4,
          stepTime: 0.1,
          textureSize: Vector2(48, 48),
          speedX: 110,
          canFly: true,
          name: 'vulture'
        ),
        EnemyData(
          image: game.images.fromCache(ImageConstants.hyena),
          nFrames: 6,
          stepTime: 0.09,
          textureSize: Vector2(48, 48),
          speedX: 130,
          canFly: false,
          name: 'hyena'
        ),
        EnemyData(
            image: game.images.fromCache(ImageConstants.deLuca),
            nFrames: 2,
            stepTime: 0.08,
            textureSize: Vector2(56, 68),
            speedX: 150,
            canFly: true,
            name: 'deLuca'
        ),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);

    // update velocity of enemies
    speedXScorpio = min(speedXScorpio + (0.15 * dt), 120);
    speedXVulture = min(speedXVulture + (0.15 * dt), 140);
    speedXHyena = min(speedXHyena + (0.15 * dt), 160);

    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = game.world.children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}