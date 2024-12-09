import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../breakout.dart';
import '../config.dart';
import 'ball.dart';
import 'bat.dart';

class Brick extends RectangleComponent with CollisionCallbacks, HasGameReference<Breakout> {
  Brick({
    required super.position,
    required Color color
  }) : _brickColor = color,
        super(
        size: Vector2(brickWidth, brickHeight),
        anchor: Anchor.center,
        paint: Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        children: [RectangleHitbox()],
      );

  final Color _brickColor;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    removeFromParent();
    game.score.value++;

    switch (_brickColor) {
      case clearBlue:
        break;

      case bigBallBrickColor:
        Future.delayed(const Duration(milliseconds: 100), () {
          game.world.children.query<Ball>().forEach((ball) {
            if(!game.isBallBig) {
              ball.size *= 3;
              ball.setColor(bigBallBrickColor);
              game.isBallBig = true;

              // Ritorno alla dimensione originale
              Future.delayed(const Duration(seconds: 15), () {
                ball.size /= 3;
                ball.setColor(clearBlue);
                game.isBallBig = false;
              });
            }
          });
        });
        break;

      case bigBatBrickColor:
        game.world.children.query<Bat>().forEach((bat) {
          if(!game.isBatBig) {
            bat.size.x *= 2.5;
            bat.setColor(bigBatBrickColor);
            game.isBatBig = true;

            // Ritorno alla dimensione originale
            Future.delayed(const Duration(seconds: 15), () {
              bat.size.x /= 2.5;
              bat.setColor(clearBlue);
              game.isBatBig = false;
            });
          }
        });
      break;
    }

    if (game.world.children.query<Brick>().length == 1) {
      game.playState = PlayState.won;
      game.handleWon();
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Bat>());
    }
  }
}

