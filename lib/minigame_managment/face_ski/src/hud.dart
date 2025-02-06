import 'dart:async';
import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Viewport;

class Hud extends PositionComponent with ParentIsA<Viewport>, HasGameReference {
  Hud({
    required Sprite playerSprite,
    required Sprite snowmanSprite,
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
        ),
        _snowman = SpriteComponent(
          sprite: snowmanSprite,
          anchor: Anchor.center,
          scale: Vector2.all(0.6),
        );


  final _score = TextComponent(
    text: 'x0',
    anchor: Anchor.centerLeft,
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 8,
      ),
    ),
  );

  final SpriteComponent _player1;
  final SpriteComponent _player2;
  final SpriteComponent _player3;
  final SpriteComponent _snowman;

  @override
  Future<void> onLoad() async {
    _player1.position.setValues(
      12,
      13,
    );

    _player2.position.setValues(
      24,
      13,
    );

    _player3.position.setValues(
      36,
      13,
    );

    _snowman.position.setValues(
      parent.virtualSize.x - 35,
      _player1.y,
    );

    _score.position.setValues(
      _snowman.position.x + 8,
      _snowman.position.y,
    );

    await addAll([_player1, _player2, _player3, _snowman, _score]);
  }

  void updateSnowmanCount(int count) {
    _score.text = 'x$count';

    _snowman.add(
      RotateEffect.by(
        pi / 8,
        RepeatedEffectController(ZigzagEffectController(period: 0.2), 2),
      ),
    );

    _score.add(
      ScaleEffect.by(
        Vector2.all(1.5),
        EffectController(
          duration: 0.1,
          alternate: true,
        ),
      ),
    );
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
