import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:mimix_app/minigame_managment/dino_run/src/dino_run.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/components/enemy.dart';

import '../config.dart';

enum DinoAnimationStates {
  idle,
  run,
  kick,
  hit,
}

class Dino extends SpriteAnimationGroupComponent<DinoAnimationStates>
    with CollisionCallbacks, HasGameReference<DinoRun> {

  static final _animationMap = {
    DinoAnimationStates.idle: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
    ),
    DinoAnimationStates.run: SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4) * 24, 0),
    ),
    DinoAnimationStates.hit: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6 + 4) * 24, 0),
    ),
  };

  double yMax = 0.0;
  double speedY = 0.0;
  static const double gravity = 575;

  final Timer _hitTimer = Timer(1);
  bool isHit = false;

  Dino(Image image) : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    _reset();

    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );
    yMax = y;

    _hitTimer.onTick = () {
      current = DinoAnimationStates.run;
      isHit = false;
    };

    super.onMount();
  }

  @override
  void update(double dt) {
    speedY += gravity * dt;

    y += speedY * dt;

    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      if ((current != DinoAnimationStates.hit) &&
          (current != DinoAnimationStates.run)) {
        current = DinoAnimationStates.run;
      }
    }

    // while isHit --> current is updated
    if (isHit){
      current = DinoAnimationStates.hit;
    }

    _hitTimer.update(dt);

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Enemy) && (!isHit)) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  bool get isOnGround => (y >= yMax);

  void jump() {
    if (isOnGround && current == DinoAnimationStates.run) {
      // FlameAudio.play(AudioConstants.jump);
      speedY = -400;
      current = DinoAnimationStates.idle;
    }
  }

  void superJump(){
    if (isOnGround && current == DinoAnimationStates.run) {
      if (game.charges.value >= 1) {
        // FlameAudio.play(AudioConstants.jump);
        game.chargeTimer.stop();
        game.chargeTimer.start();
        speedY = -480;
        current = DinoAnimationStates.idle;
        game.charges.value = game.charges.value - 1;
      }
    }
  }

  void hit() {
    // FlameAudio.play(AudioConstants.hit);
    isHit = true;
    current = DinoAnimationStates.hit;
    _hitTimer.start();
    game.lives.value -= 1;
  }

  void _reset() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(16, game.virtualSize.y - 10);
    size = Vector2.all(64);
    current = DinoAnimationStates.run;
    isHit = false;
    speedY = 0.0;
  }
}
