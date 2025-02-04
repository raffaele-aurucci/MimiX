import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart' hide Route, OverlayRoute;
import 'package:mimix_app/minigame_managment/face_ski/src/globals.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/routes/gameplay.dart';

class FaceSkiGame extends FlameGame with HasCollisionDetection {

  // player data accessible to external
  final ValueNotifier<int> score = ValueNotifier(0);
  final ValueNotifier<int> lives = ValueNotifier(5);

  // Riferimento al componente Gameplay
  late Gameplay gameplay;

  @override
  Color backgroundColor() => const Color.fromARGB(255, 238, 248, 254);

  @override
  void update(double dt) {
    super.update(dt);

    if (GlobalState.isPaused) {
      pauseEngine();
    }
  }

  void startGame() {
    Flame.device.setPortrait();
    Flame.device.fullScreen();
    print("Avvio nuova partita...");

    // Reset delle variabili globali
    score.value = 0;
    lives.value = 5;
    GlobalState.isPaused = false;

    GlobalState.active = false;

    // Ricreiamo il gameplay da zero
    gameplay = Gameplay(
      onLevelCompleted: _handleLevelCompleted,
      onGameOver: _handleGameOver,
    );

    // Aggiungiamo il nuovo gameplay pulito
    add(gameplay);

    // Forza un'avvio completo del gioco, senza pause
    resumeGame();
  }


  void resumeGame() {
    GlobalState.isPaused = false;
    resumeEngine();
  }

  void restartGame() {

    // Reset delle variabili di stato
    score.value = 0;
    lives.value = 5;
    GlobalState.isPaused = false;

    // Reset dei trigger della pista e altre variabili globali
    GlobalState.active = false;

    // Rimuove il vecchio gameplay e ne crea uno nuovo
    remove(gameplay);
    gameplay = Gameplay(
      onLevelCompleted: _handleLevelCompleted,
      onGameOver: _handleGameOver,
    );
    add(gameplay);
    resumeEngine();
  }

  // TODO
  void _handleLevelCompleted(int stars) {
    print("Livello Completato");
  }

  void _handleGameOver() {
    callGamePageMethod();
  }

  // Callback per chiamare un metodo di FaceSkiGamePage
  final VoidCallback? onGameOverMethodCalled;

  FaceSkiGame({this.onGameOverMethodCalled});

  void callGamePageMethod() {
    if (onGameOverMethodCalled != null) {
      onGameOverMethodCalled!(); // Chiamata al metodo di FaceSkiGamePage
    }
  }
}


