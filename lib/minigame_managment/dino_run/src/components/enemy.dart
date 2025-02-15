import 'dart:ui';

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

    if (enemyData.name == 'deLuca') {
      add(
        CircleHitbox(
          radius: size.x * 0.5,
          position: Vector2(size.x * 0.05, size.y * 0.01) / 2,
        ),
      );
    }

    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= enemyData.speedX * dt;

    // enemy visible in widget game
    if (enemyData.name != 'deLuca') {
      if (position.x <= game.virtualSize.x - 42) {
        opacity = 1.0;
      }
    }

    if (enemyData.name == 'deLuca') {
      if (position.x <= game.virtualSize.x - 65) {
        opacity = 1.0;
      }
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


  @override
  void render(Canvas canvas) {

    // Visible side.
    double visibleWidth = size.x + position.x;
    if (visibleWidth > size.x) visibleWidth = size.x;
    if (visibleWidth < 0) visibleWidth = 0;

    // Clipping (left side).
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(size.x - visibleWidth, 0, visibleWidth, size.y));

    // Render clipped sprite.
    super.render(canvas);
    canvas.restore();
  }

  //TODO: fix for right side.
  /*@override
  void render(Canvas canvas) {

    double visibleWidthRight = size.x;

    // if ((game.size.x - position.x) >= -size.x) {
    //   visibleWidthRight = -(game.size.x - position.x);  // Mostra solo la parte visibile
    // }

    if (position.x >= game.size.x - size.x && position.x <= game.size.x) {
      visibleWidthRight = -(game.size.x - position.x);
    }
    else if (position.x > game.size.x) visibleWidthRight = 0;

    print('position.x = ${position.x}');
    print('visibleWidthRight = ${visibleWidthRight}');

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(- size.x - visibleWidthRight, 0, -visibleWidthRight, size.y));

    super.render(canvas);
    canvas.restore();
  }*/

}
