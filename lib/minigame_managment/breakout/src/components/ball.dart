import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:mimix_app/minigame_managment/breakout/src/config.dart';

import '../breakout.dart';
import 'bat.dart';
import 'brick.dart';
import 'play_area.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<Breakout> {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
      radius: radius,
      anchor: Anchor.center,
      paint: Paint()
        ..color = clearBlue
        ..style = PaintingStyle.fill,
      children: [CircleHitbox()]);

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
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
    } else if (other is Bat) {
      velocity.y = -velocity.y;
    } else if (other is Brick) {
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
