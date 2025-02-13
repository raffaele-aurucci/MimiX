import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../breakout.dart';
import '../config.dart';

class Bat extends SpriteComponent with HasGameReference<Breakout> {
  late Sprite _originalSprite;

  Bat({
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

    // Limit position of bat
    double newX = position.x + dx;
    newX = newX.clamp(size.x / 2, game.width - size.x / 2);

    // add(MoveToEffect(
    //   Vector2((position.x + dx).clamp(0, game.width), position.y),
    //   EffectController(duration: 0.1),
    // ));

    add(MoveToEffect(
      Vector2(newX, position.y),
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

