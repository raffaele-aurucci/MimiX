import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../breakout.dart';
import '../config.dart';
import 'ball_new.dart';
import 'bat_new.dart';

class BrickNew extends SpriteComponent with CollisionCallbacks, HasGameReference<Breakout> {
  BrickNew({
    required super.position,
    required Color color
  }) : _brickColor = color,
        super(
        size: Vector2(brickWidth, brickHeight),
        anchor: Anchor.center,
      );

  final Color _brickColor;

  @override
  Future<void> onLoad() async {

    Rect brickRect = brickBlue;

    switch(_brickColor){
      case Colors.red: brickRect = brickRed;
      case Colors.yellow: brickRect = brickYellow;
      case Colors.blue: brickRect = brickBlue;
    }

    // Create sprite from rect
    sprite = Sprite(
        game.spriteSheet.image,
        srcPosition: Vector2(brickRect.left, brickRect.top),
        srcSize: Vector2(brickRect.width, brickRect.height)
    );
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    removeFromParent();
    game.score.value++;

    switch (_brickColor) {

      case Colors.red:
        Future.delayed(const Duration(milliseconds: 100), () {
          game.world.children.query<BallNew>().forEach((ball) {
            if(!game.isBallBig) {
              ball.size *= 1.7;
              ball.sprite = Sprite(
                  game.spriteSheet.image,
                  srcPosition: Vector2(ballRedRect.left, ballRedRect.top),
                  srcSize: Vector2(ballRedRect.width, ballRedRect.height)
              );
              game.isBallBig = true;

              Future.delayed(const Duration(seconds: 15), () {
                ball.size /= 1.7;
                ball.resetSprite();
                game.isBallBig = false;
              });
            }
          });
        });
        break;

      case Colors.yellow:
        game.world.children.query<BatNew>().forEach((bat) {
          if (!game.isBatBig) {
            bat.size.x *= 2;
            bat.setSprite(game.bigBatSprite);
            game.isBatBig = true;

            Future.delayed(const Duration(seconds: 15), () {
              bat.size.x /= 2;
              bat.resetSprite();
              game.isBatBig = false;
            });
          }
        });
        break;
    }

    if (game.world.children.query<BrickNew>().length == 1) {
      game.playState = PlayState.won;
      game.handleWon();
      game.world.removeAll(game.world.children.query<BallNew>());
      game.world.removeAll(game.world.children.query<BatNew>());
    }
  }
}

