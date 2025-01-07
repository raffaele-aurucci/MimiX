import 'dart:math';

import 'package:flame/components.dart';

import 'package:mimix_app/minigame_managment/dino_run/src/config.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/dino_run.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/components/enemy.dart';


class EnemyManager extends Component with HasGameReference<DinoRun> {

  final List<EnemyData> _data = [];

  final Random _random = Random();

  final Timer _timer = Timer(3, repeat: true);

  // each 3 seconds spawn a random enemy
  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  void spawnRandomEnemy() {
    final randomIndex = _random.nextInt(_data.length);
    final enemyData = _data.elementAt(randomIndex);
    final enemy = Enemy(enemyData);

    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      game.virtualSize.x + 32, // da destra verso sx
      game.virtualSize.y - 12, // da basso verso l'alto
    );

    // random y position for 'vulture' enemy
    if (enemyData.canFly) {
      final newHeight = _random.nextDouble() * 2 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;
    }

    enemy.opacity = 0;
    enemy.size = enemyData.textureSize;

    game.world.add(enemy);
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
          speedX: 150,
          canFly: false,
          name: 'hyena'
        ),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = game.world.children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}