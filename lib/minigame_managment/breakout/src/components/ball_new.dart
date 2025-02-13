import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:mimix_app/minigame_managment/breakout/src/config.dart';

import '../breakout.dart';
import 'bat_new.dart';
import 'brick_new.dart';
import 'play_area.dart';

class BallNew extends SpriteComponent
    with CollisionCallbacks, HasGameReference<Breakout> {

  BallNew({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
    size: Vector2.all(radius * 2), // La dimensione è il diametro
    anchor: Anchor.center,
  );

  final Vector2 velocity;
  late Sprite _originalSprite;

  @override
  Future<void> onLoad() async {
    _originalSprite = Sprite(
        game.spriteSheet.image,
        srcPosition: Vector2(ballBlueRect.left, ballBlueRect.top),
        srcSize: Vector2(ballBlueRect.width, ballBlueRect.height)
    );
    sprite = _originalSprite;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  void setSprite(Sprite newSprite) {
    sprite = newSprite;
  }

  void resetSprite() {
    sprite = _originalSprite; // Torna allo sprite originale
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        add(RemoveEffect(
            delay: 0.35,
            onComplete: () {
              game.playState = PlayState.gameOver;
              game.handleGameOver();
            }));
      }
    } else if (other is BatNew) {
      velocity.y = -velocity.y;
    } else if (other is BrickNew) {
      if (position.y < other.position.y - other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.x < other.position.x) {
        velocity.x = -velocity.x;
      } else if (position.x > other.position.x) {
        velocity.x = -velocity.x;
      }
    }
  }
}
