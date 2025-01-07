import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../dino_run.dart';

class LivesDisplay extends PositionComponent with HasGameReference<DinoRun>{
  int _lives;
  final double heartSize = 30.0;

  LivesDisplay({required int lives}) : _lives = lives;

  int get lives => _lives;

  set lives(int newLives) {
    _lives = newLives;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(game.virtualSize.x / 2 - 75, 20);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // synchronized with interface
    lives = game.lives.value;

    const heartIcon = Icons.favorite;
    const emptyHeartIcon = Icons.favorite_border;

    String hearts = '';

    hearts += List.filled(_lives, String.fromCharCode(heartIcon.codePoint)).join('');
    hearts += List.filled(5 - _lives, String.fromCharCode(emptyHeartIcon.codePoint)).join('');

    final heartsPosition = Vector2(0, 0);

    final text = TextComponent(
      text: hearts,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: heartSize,
          color: Colors.red,
          fontFamily: heartIcon.fontFamily,
        ),
      ),
    );

    text.position = heartsPosition;
    text.render(canvas);
  }
}
