import 'dart:async';
import 'dart:io' show Platform;

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart' hide Route, OverlayRoute;

// import 'package:flame_audio/flame_audio.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/routes/gameplay.dart';

enum FaceSkiPlayState { welcome, playing, gameOver, isPaused}

class FaceSkiGame extends FlameGame with HasCollisionDetection {
  FaceSkiGame() : super() {
    playState = FaceSkiPlayState.welcome;
  }

  // player data accessible to external
  final ValueNotifier<int> score = ValueNotifier(0);
  final ValueNotifier<int> lives = ValueNotifier(5);

  static final isMobile = Platform.isAndroid || Platform.isIOS;

  // state of game accessible to external
  late FaceSkiPlayState playState;

  // Riferimento al componente Gameplay
  late Gameplay gameplay;

  @override
  Color backgroundColor() => const Color.fromARGB(255, 238, 248, 254);

  @override
  Future<void> onLoad() async {
    await Flame.device.setPortrait();
    await Flame.device.fullScreen();
    await Future.delayed(Duration(seconds: 3));
    startGame();
  }

  void startGame() {

    // Creiamo il gameplay con i callback necessari
    gameplay = Gameplay(
      3,
      onPausePressed: _handlePause,
      onLevelCompleted: _handleLevelCompleted,
      onGameOver: _handleGameOver,
    );

    // Aggiungiamo il componente al gioco
    add(gameplay);

    // Impostiamo lo stato del gioco su "playing"
    playState = FaceSkiPlayState.playing;
  }

  // TODO
  void _handlePause() {
    // Logica per gestire la pausa
    playState = FaceSkiPlayState.isPaused;
    overlays.add('PauseMenu'); // Mostriamo un overlay (esempio)
  }

  // TODO
  void _handleLevelCompleted(int stars) {
    // Logica per il completamento del livello
    overlays.add('LevelComplete');
    playState = FaceSkiPlayState.gameOver;
    startGame();
  }

  // TODO
  void _handleGameOver() {
    // Logica per il game over
    overlays.add('GameOver');
    playState = FaceSkiPlayState.gameOver;
    startGame();
  }

  // TODO: Restart game (from handleGameOver, handleRestart)
  void resetGame() {
    // Logica per il reset del gioco
    remove(gameplay);
    startGame(); // Riavviamo il gioco al livello 1
  }

}


