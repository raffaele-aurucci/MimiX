import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../breakout.dart';

class Bat extends PositionComponent with HasGameReference<Breakout> {
  Bat({
    required this.cornerRadius,
    required super.position,
    required super.size,
    required Color color
  }) : _batColor = color,
        super(
        anchor: Anchor.center,
        children: [RectangleHitbox()],
      );

  final Radius cornerRadius;
  Color _batColor; // Colore corrente della bat

  void setColor(Color color) {
    _batColor = color; // Aggiorna il colore della bat
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Crea un nuovo Paint con il colore aggiornato ogni volta che viene chiamato `render`
    final paint = Paint()
      ..color = _batColor  // Usa il colore attuale della bat
      ..style = PaintingStyle.fill;

    // Disegna la bat con il nuovo colore
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),
        cornerRadius,
      ),
      paint,
    );
  }

  void moveBy(double dx) {
    add(MoveToEffect(
      Vector2((position.x + dx).clamp(0, game.width), position.y),
      EffectController(duration: 0.1),
    ));
  }
}
