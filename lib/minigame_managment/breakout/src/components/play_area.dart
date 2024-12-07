import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../breakout.dart';

class PlayArea extends RectangleComponent with HasGameReference<Breakout> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xffffffff),
          children: [RectangleHitbox()],
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}