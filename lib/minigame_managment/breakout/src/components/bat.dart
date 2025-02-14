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
  }) : super(anchor: Anchor.center){
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    _originalSprite = Sprite(
      game.spriteSheet.image,
      srcPosition: Vector2(batRect.left, batRect.top),
      srcSize: Vector2(batRect.width, batRect.height),
    );
    sprite = _originalSprite;
    updateHitbox(Vector2(size.x, size.y * 0.1));
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

  void updateHitbox(Vector2 newSize) {
    removeWhere((component) => component is RectangleHitbox);

    add(RectangleHitbox(
      size: newSize,
      position: Vector2((size.x - newSize.x) / 2, 0),
    ));
  }


  void setSprite(Sprite newSprite) {
    sprite = newSprite;
    updateHitbox(Vector2(size.x, size.y * 0.1));
  }

  void resetSprite() {
    sprite = _originalSprite;
    updateHitbox(Vector2(size.x, size.y * 0.1));
  }
}

