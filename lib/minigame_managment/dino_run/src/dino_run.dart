import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/components/charges.dart';

import 'package:mimix_app/minigame_managment/dino_run/src/config.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/components/dino.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/components/enemy_manager.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/components/background.dart';

import 'components/lives.dart';


enum PlayState { welcome, playing, gameOver, isPaused}


class DinoRun extends FlameGame with TapCallbacks, HasCollisionDetection, DragCallbacks {

  final Function handleGameOver;

  DinoRun({required this.handleGameOver}) : super (
      camera: CameraComponent() // no fixed size for delete horizontal black line
  ) {
    playState = PlayState.welcome;
  }

  static const _imageAssets = [
    ImageConstants.dino,
    ImageConstants.hyena,
    ImageConstants.vulture,
    ImageConstants.scorpio,
    ImageConstants.deLuca
  ];

  // comment for best performance
  //
  // static const _audioAssets = [
  //   AudioConstants.hurt,
  //   AudioConstants.jump,
  // ];

  late Dino _dino;
  EnemyManager? _enemyManager;

  // logic area of the game
  Vector2 get virtualSize => camera.viewport.virtualSize;

  @override
  bool get debugMode => false;

  // player data accessible to external
  final ValueNotifier<int> score = ValueNotifier(0);
  final ValueNotifier<int> lives = ValueNotifier(5);
  final ValueNotifier<int> charges = ValueNotifier(3); // used for superJump

  // state of game accessible to external
  late PlayState playState;

  // display for lives and charges
  late LivesDisplay livesDisplay;
  late ChargesDisplay chargesDisplay;

  // timer to recharge
  final Timer chargeTimer = Timer(4, repeat: true);

  @override
  Future<void> onLoad() async {
    playState = PlayState.welcome;

    // load sprites into cache
    await images.loadAll(_imageAssets);

    // await FlameAudio.audioCache.loadAll(_audioAssets);

    // lives display
    livesDisplay = LivesDisplay(lives: lives.value);
    world.add(livesDisplay);

    // charges display
    chargesDisplay = ChargesDisplay(charges: charges.value);
    world.add(chargesDisplay);

    // center the "viewfinder" of camera
    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    // under other objects (dino and enemies)
    camera.backdrop.add(BackGroundScreen(speed: 100));

    _dino = Dino(images.fromCache(ImageConstants.dino));
    world.add(_dino);

    chargeTimer.onTick = () {
      if (charges.value < 3) {
        charges.value = charges.value + 1;
      }
    };
  }

  // startGame is necessary to playing
  void startGame() {

    if (_dino.isMounted){
      _dino.removeFromParent();
    }

    chargeTimer.start();

    playState = PlayState.playing;

    _dino = Dino(images.fromCache(ImageConstants.dino));
    _enemyManager = EnemyManager();

    world.add(_dino);
    world.add(_enemyManager!);
  }

  @override
  void update(double dt) {

    // update chargeTimer
    chargeTimer.update(dt);

    // update parallax velocity
    if (playState != PlayState.welcome) {

      if (camera.backdrop.firstChild<BackGroundScreen>() != null){
        var speed = camera.backdrop.firstChild<BackGroundScreen>()!.speed;
        speed = min(speed + (0.35 * dt), 150);
        camera.backdrop.firstChild<BackGroundScreen>()!.speed = speed;
        if (camera.backdrop.firstChild<BackGroundScreen>()!.parallax != null) {
          camera.backdrop.firstChild<BackGroundScreen>()!.parallax!.baseVelocity = Vector2(speed / pow(2, 6), 0);
        }
      }

    }

    // game over
    _checkGameOver();
    super.update(dt);
  }

  void jumpDino() {
    if (playState == PlayState.playing) {
      _dino.jump();
    }
  }

  void superJumpDino() {
    if (playState == PlayState.playing) {
      _dino.superJump(); // all controls is into _dino
    }
  }

  void _checkGameOver() {
    if (lives.value <= 0) {
      chargeTimer.stop();
      playState = PlayState.gameOver;
      pauseEngine();
      handleGameOver();
    }
  }

  void resetGame() {
    if (playState == PlayState.isPaused || playState == PlayState.gameOver) {

      // remove all children
      if (_dino.isMounted) {
        _dino.removeFromParent();
      }
      if (_enemyManager != null && _enemyManager!.isMounted) {
        _enemyManager!.removeAllEnemies();
        _enemyManager!.removeFromParent();
      }

      // reset scores and state
      score.value = 0;
      lives.value = 5;
      charges.value = 3;

      // reset velocity of parallax
      if (camera.backdrop.firstChild<BackGroundScreen>() != null){
        double speed = 100;
        camera.backdrop.firstChild<BackGroundScreen>()!.speed = speed;
        if (camera.backdrop.firstChild<BackGroundScreen>()!.parallax != null) {
          camera.backdrop.firstChild<BackGroundScreen>()!.parallax!.baseVelocity = Vector2(speed / pow(2, 6), 0);
        }
      }

      resumeEngine();
      startGame();
    }
  }
}
