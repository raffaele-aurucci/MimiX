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
  })  : _player = SpriteComponent(
          sprite: playerSprite,
          anchor: Anchor.center,
          scale: Vector2.all(0.6),
        ),
        _snowman = SpriteComponent(
          sprite: snowmanSprite,
          anchor: Anchor.center,
          scale: Vector2.all(0.6),
        );

  final _life = TextComponent(
    text: 'x3',
    anchor: Anchor.centerLeft,
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 8,
      ),
    ),
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

  final SpriteComponent _player;
  final SpriteComponent _snowman;

  @override
  Future<void> onLoad() async {
    _player.position.setValues(
      16,
      10,
    );

    _life.position.setValues(
      _player.position.x + 8,
      _player.position.y,
    );

    _snowman.position.setValues(
      parent.virtualSize.x - 35,
      _player.y,
    );

    _score.position.setValues(
      _snowman.position.x + 8,
      _snowman.position.y,
    );

    await addAll([_player, _life, _snowman, _score]);
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
    _life.text = 'x$count';

    _player.add(
      RotateEffect.by(
        pi / 8,
        RepeatedEffectController(ZigzagEffectController(period: 0.2), 2),
      ),
    );

    _life.add(
      ScaleEffect.by(
        Vector2.all(1.5),
        EffectController(
          duration: 0.1,
          alternate: true,
        ),
      ),
    );
  }
}
