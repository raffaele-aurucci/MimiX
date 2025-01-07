import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../dino_run.dart';

class ChargesDisplay extends PositionComponent with HasGameReference<DinoRun>{
  int _charges;
  final double boltSize = 25.0;

  ChargesDisplay({required int charges}) : _charges = charges;

  int get charges => _charges;

  set charges(int newCharges) {
    _charges = newCharges;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(game.virtualSize.x / 2 - 37.5, 55);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // synchronized with interface
    charges = game.charges.value;

    const boltIcon = Icons.offline_bolt_sharp;
    const emptyBoltIcon = Icons.offline_bolt_outlined;

    String bolts = '';

    bolts += List.filled(_charges, String.fromCharCode(boltIcon.codePoint)).join('');
    bolts += List.filled(3 - _charges, String.fromCharCode(emptyBoltIcon.codePoint)).join('');

    final boltsPosition = Vector2(0, 0);

    final text = TextComponent(
      text: bolts,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: boltSize,
          color: Colors.yellow,
          fontFamily: boltIcon.fontFamily,
        ),
      ),
    );

    text.position = boltsPosition;
    text.render(canvas);
  }
}
