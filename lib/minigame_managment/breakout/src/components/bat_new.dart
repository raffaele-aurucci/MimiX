import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../breakout.dart';
import '../config.dart';

class BatNew extends SpriteComponent with HasGameReference<Breakout> {
  late Sprite _originalSprite;

  BatNew({
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    _originalSprite = Sprite(
      game.spriteSheet.image,
      srcPosition: Vector2(batRect.left, batRect.top),
      srcSize: Vector2(batRect.width, batRect.height),
    );
    sprite = _originalSprite;

    add(RectangleHitbox());
  }

  void moveBy(double dx) {
    add(MoveToEffect(
      Vector2((position.x + dx).clamp(0, game.width), position.y),
      EffectController(duration: 0.1),
    ));
  }

  void setSprite(Sprite newSprite) {
    sprite = newSprite;
  }

  void resetSprite() {
    sprite = _originalSprite;
  }
}

