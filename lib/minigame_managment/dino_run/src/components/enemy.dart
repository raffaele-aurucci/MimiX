import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:mimix_app/minigame_managment/dino_run/src/config.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/dino_run.dart';

class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<DinoRun> {

  final EnemyData enemyData;

  bool isVisible = false;

  Enemy(this.enemyData) {
    animation = SpriteAnimation.fromFrameData(
      enemyData.image,
      SpriteAnimationData.sequenced(
        amount: enemyData.nFrames,
        stepTime: enemyData.stepTime,
        textureSize: enemyData.textureSize,
      ),
    );
  }

  @override
  void onMount() {
    size *= 0.8;

    if (enemyData.name == 'hyena') {
      add(
        RectangleHitbox.relative(
          Vector2.all(0.75),
          parentSize: size,
          position: Vector2(size.x * 0.4, size.y * 0.95) / 2,
        ),
      );
    }

    if (enemyData.name == 'vulture') {
      add(
        RectangleHitbox.relative(
          Vector2.all(0.6),
          parentSize: size,
          position: Vector2(size.x * 0.65, size.y * 0.6) / 2,
        ),
      );
    }

    if (enemyData.name == 'scorpio') {
      add(
        RectangleHitbox.relative(
          Vector2.all(0.6),
          parentSize: size,
          position: Vector2(size.x * 0.65, size.y * 1.05) / 2,
        ),
      );

    }

    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= enemyData.speedX * dt;

    // enemy visible in widget game
    if (position.x <= game.virtualSize.x - 32) {
      opacity = 1.0;
    }

    // enemy not visible in widget game
    if (position.x <= -15 && enemyData.name == 'scorpio') {
      opacity = 0;
    }
    else if (position.x <= -10 && enemyData.name == 'vulture') {
      opacity = 0;
    }
    else if (position.x <= -5 && enemyData.name == 'hyena') {
      opacity = 0;
    }

    // delete enemy and update score
    if (position.x < -enemyData.textureSize.x) {
      removeFromParent();
      if (game.lives.value == 5) {
        game.score.value += 150;
      } else if (game.lives.value == 4) {
        game.score.value += 300;
      } else if (game.lives.value == 3) {
        game.score.value += 450;
      } else if (game.lives.value == 2) {
        game.score.value += 600;
      } else if (game.lives.value == 1) {
        game.score.value += 750;
      }
    }

    super.update(dt);
  }
}
