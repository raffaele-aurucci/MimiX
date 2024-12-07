import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import 'config.dart';

enum PlayState { welcome, playing, gameOver, won, isPaused }


class Breakout extends FlameGame with HasCollisionDetection {

  // external function to handle game over and win (for UI)
  final Function handleGameOver;
  final Function handleWon;

  Breakout({
    required this.handleGameOver,
    required this.handleWon,
  }) : super(
    camera: CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
    ),
  ) {
    _playState = PlayState.welcome;
  }

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // Score of game accessible to external.
  final ValueNotifier<int> score = ValueNotifier(0);

  // State of game accessible to external.
  late PlayState _playState;

  PlayState get playState => _playState;

  set playState(PlayState state) {
    _playState = state;
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;

    // Add objects to scene but not start the game.

    world.add(Bat(
        size: Vector2(batWidth, batHeight),
        cornerRadius: const Radius.circular(batRadius / 2),
        position: Vector2(width / 2, height * 0.95)));

    world.addAll([
      for (var i = 0; i < 10; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            position: Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: (i%2!=0) ? brickColor : specialBrickColor,
          ),
    ]);
  }

  // Using this method to start game to external.
  void startGame() {
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());

    playState = PlayState.playing;

    score.value = 0;

    world.add(Ball(
        difficultyModifier: difficultyModifier,
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2)
            .normalized()
          ..scale(height / 4)));

    world.add(Bat(
        size: Vector2(batWidth, batHeight),
        cornerRadius: const Radius.circular(batRadius / 2),
        position: Vector2(width / 2, height * 0.95)));

    world.addAll([
      for (var i = 0; i < 10; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            position: Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: (i%2!=0) ? brickColor : specialBrickColor,
          ),
    ]);
  }

  @override
  void update(double dt) {
    // Not update the game.
    if (_playState == PlayState.isPaused) {
      return;
    }
    super.update(dt);
  }

  @override
  Color backgroundColor() => const Color(0xffffffff);

  void moveBatLeft() {
    if (playState == PlayState.playing) {
      world.children.query<Bat>().first.moveBy(-batStep);
    }
  }

  void moveBatRight() {
    if (playState == PlayState.playing) {
      world.children.query<Bat>().first.moveBy(batStep);
    }
  }

}