import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import 'package:mimix_app/minigame_managment/dino_run/src/config.dart';

class BackGroundScreen extends ParallaxComponent {
  BackGroundScreen({required this.speed});
  final double speed;
  @override
  FutureOr<void> onLoad() async {
    final layers = [
      ParallaxImageData(ImageConstants.plx1),
      ParallaxImageData(ImageConstants.plx2),
      ParallaxImageData(ImageConstants.plx3),
      ParallaxImageData(ImageConstants.plx4),
      ParallaxImageData(ImageConstants.plx5),
      ParallaxImageData(ImageConstants.plx6),
    ];
    final baseVelocity = Vector2(speed / pow(2, layers.length), 0);
    final velocityMutiplierDelta = Vector2(2.0, 0.0);
    parallax = await game.loadParallax(
      layers,
      baseVelocity: baseVelocity,
      velocityMultiplierDelta: velocityMutiplierDelta,
      filterQuality: FilterQuality.none,
    );
    return super.onLoad();
  }
}
