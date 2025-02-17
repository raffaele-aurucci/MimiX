import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flutter/widgets.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/game.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/globals.dart';

import '../routes/gameplay.dart';

class Player extends PositionComponent
    with HasGameReference<FaceSkiGame>, HasAncestor<Gameplay>, HasTimeScale {
  Player({super.position, required Sprite sprite, super.priority})
      : _body = SpriteComponent(sprite: sprite, anchor: Anchor.center);

  late double orientation = 0.0;
  final SpriteComponent _body;
  final _moveDirection = Vector2(0, 1);

  late final _trailParticlePaint = Paint()..color = game.backgroundColor();
  late final _offsetLeft = Vector2(-_body.width * 0.25, 0);
  late final _offsetRight = Vector2(_body.width * 0.25, 0);
  bool left = false;


  static const _rotationSpeed = 5.0;
  var _speed = 0.0;
  var _isOnGround = true;
  var _maxSpeed = 50.0;
  var _acceleration = 0.4;

  @override
  Future<void> onLoad() async {
    await add(_body);
    await add(
      CircleHitbox.relative(1, parentSize: _body.size, anchor: Anchor.center),
    );
  }

  @override
  void update(double dt) {
    _moveDirection.x = GlobalState.playerOrientation;
    _moveDirection.y = 1;

    _moveDirection.normalize();
    _speed = lerpDouble(_speed, _maxSpeed, _acceleration * dt)!;

    // Rotazione dolce verso la nuova direzione con il percorso più breve
    final targetAngle = _moveDirection.screenAngle() + pi;
    double angleDifference = (targetAngle - angle) % (2 * pi);
    if (angleDifference > pi) {
      angleDifference -= 2 * pi;
    }
    angle += angleDifference * (_rotationSpeed * dt);

    position.addScaled(_moveDirection, _speed * dt);

    if (_isOnGround) {
      parent?.add(
        ParticleSystemComponent(
          position: position,
          particle: Particle.generate(
            count: 2,
            lifespan: 2,
            generator: (index) {
              return TranslatedParticle(
                child: CircleParticle(
                  radius: 0.8,
                  paint: _trailParticlePaint,
                ),
                offset: index == 0 ? _offsetLeft : _offsetRight,
              );
            },
          ),
        ),
      );
    }
  }

  void resetTo(Vector2 resetPosition) {
    position.setFrom(resetPosition);
    _speed *= 0.5;
  }

  double jump() {
    _isOnGround = false;
    final jumpFactor = _speed / _maxSpeed;
    final jumpScale = lerpDouble(1, 1.2, jumpFactor)!;
    final jumpDuration = lerpDouble(0, 0.8, jumpFactor)!;

    _body.add(
      ScaleEffect.by(
        Vector2.all(jumpScale),
        EffectController(
          duration: jumpDuration,
          alternate: true,
          curve: Curves.easeInOut,
        ),
        onComplete: () => _isOnGround = true,
      ),
    );

    return jumpFactor;
  }

  void blockMovement() {
    _speed = 0.0;
    _maxSpeed = 0.0;
    _acceleration = 0.0;
  }

  void unblockMovement() {
    _maxSpeed = 50.0;
    _acceleration = 0.4;
  }
}
