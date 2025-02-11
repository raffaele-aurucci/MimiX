import 'dart:async';
import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Viewport;

import 'globals.dart';

class Hud extends PositionComponent with ParentIsA<Viewport>, HasGameReference {
  Hud({
    required Sprite playerSprite,
  })  : _player1 = SpriteComponent(
          sprite: playerSprite,
          anchor: Anchor.center,
          scale: Vector2.all(0.6),
        ),
        _player2 = SpriteComponent(
          sprite: playerSprite,
          anchor: Anchor.center,
          scale: Vector2.all(0.6),
        ),
        _player3 = SpriteComponent(
          sprite: playerSprite,
          anchor: Anchor.center,
          scale: Vector2.all(0.6),
        );


  final SpriteComponent _player1;
  final SpriteComponent _player2;
  final SpriteComponent _player3;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    const xPosition= 68.0;
    const yPosition = 14.0;

    const spacing = 12.0;

    _player1.position.setValues(xPosition - spacing, yPosition);
    _player2.position.setValues(xPosition, yPosition);
    _player3.position.setValues(xPosition + spacing, yPosition);

    if(!GlobalState.isPreviewPage){
      await addAll([_player1, _player2, _player3]);
    }
  }

  void updateLifeCount(int count) {
    // Effetto di rotazione sui player quando la vita cambia
    _player1.add(
      RotateEffect.by(
        pi / 8,
        RepeatedEffectController(ZigzagEffectController(period: 0.2), 2),
      ),
    );

    _player2.add(
      RotateEffect.by(
        pi / 8,
        RepeatedEffectController(ZigzagEffectController(period: 0.2), 2),
      ),
    );

    _player3.add(
      RotateEffect.by(
        pi / 8,
        RepeatedEffectController(ZigzagEffectController(period: 0.2), 2),
      ),
    );

    switch(count){
      case 2:
        _player3.paint.colorFilter = ColorFilter.mode(
          Colors.grey.withOpacity(0.8),
          BlendMode.modulate,
        );
      case 1:
        _player2.paint.colorFilter = ColorFilter.mode(
          Colors.grey.withOpacity(0.8),
          BlendMode.modulate,
        );
      case 0:
        _player1.paint.colorFilter = ColorFilter.mode(
          Colors.grey.withOpacity(0.8),
          BlendMode.modulate,
        );
    }
  }
}
