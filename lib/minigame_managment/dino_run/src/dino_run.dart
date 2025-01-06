import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

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
    ImageConstants.scorpio
  ];

  late Dino _dino;
  late EnemyManager _enemyManager;

  // logic area of the game
  Vector2 get virtualSize => camera.viewport.virtualSize;

  @override
  bool get debugMode => false;

  // player data accessible to external
  final ValueNotifier<int> score = ValueNotifier(0);
  final ValueNotifier<int> lives = ValueNotifier(5);

  // state of game accessible to external
  late PlayState playState;

  late LivesDisplay livesDisplay;  // Display per le vite

  @override
  Future<void> onLoad() async {
    playState = PlayState.welcome;

    // load sprites into cache
    await images.loadAll(_imageAssets);

    // lives display
    livesDisplay = LivesDisplay(lives: lives.value);
    world.add(livesDisplay);

    // center the "viewfinder" of camera
    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    // under other objects (dino and enemies)
    camera.backdrop.add(BackGroundScreen(speed: 100));

    _dino = Dino(images.fromCache(ImageConstants.dino));
    world.add(_dino);
  }

  // startGame is necessary to playing
  void startGame() {

    if (_dino.isMounted){
      _dino.removeFromParent();
    }

    playState = PlayState.playing;

    _dino = Dino(images.fromCache(ImageConstants.dino));
    _enemyManager = EnemyManager();

    world.add(_dino);
    world.add(_enemyManager);
  }

  @override
  void update(double dt) {
    livesDisplay.lives = lives.value;
    // game over
    _checkGameOver();
    super.update(dt);
  }

  void jumpDino(){
    if (playState == PlayState.playing) {
      _dino.jump();
    }
  }

  void superJumpDino(){
    if (playState == PlayState.playing) {
      _dino.superJump();
    }
  }

  void _checkGameOver() {
    if (lives.value <= 0) {
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
      if (_enemyManager.isMounted) {
        _enemyManager.removeAllEnemies();
        _enemyManager.removeFromParent();
      }

      // reset scores and state
      score.value = 0;
      lives.value = 5;
      resumeEngine();
      startGame();
    }
  }
}
