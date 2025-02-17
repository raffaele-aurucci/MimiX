import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart' hide Route, OverlayRoute;
import 'package:mimix_app/minigame_managment/face_ski/src/globals.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/routes/gameplay.dart';

class FaceSkiGame extends FlameGame with HasCollisionDetection {

  final ValueNotifier<int> score = ValueNotifier(0);
  final ValueNotifier<int> lives = ValueNotifier(5);

  late Gameplay gameplay;

  final VoidCallback? onGameOverMethodCalled;
  final VoidCallback? onWinMethodCalled;

  FaceSkiGame({this.onWinMethodCalled, this.onGameOverMethodCalled});

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
    print("Avvio nuova partita...");

    score.value = 0;
    lives.value = 5;
    GlobalState.isPaused = false;
    GlobalState.active = false;
    GlobalState.isPlayerBlocked = false;

    gameplay = Gameplay(
      onLevelCompleted: _handleLevelCompleted,
      onGameOver: _handleGameOver,
    );

    add(gameplay);

    resumeGame();
  }

  void startGameBlocked() {
    Flame.device.setPortrait();
    print("Avvio nuova partita con player bloccato...");

    score.value = 0;
    lives.value = 5;
    GlobalState.isPaused = false;
    GlobalState.active = false;
    GlobalState.isPlayerBlocked = true;

    gameplay = Gameplay(
      onLevelCompleted: _handleLevelCompleted,
      onGameOver: _handleGameOver,
    );

    add(gameplay);

    resumeGame();
  }


  void resumeGame() {
    GlobalState.isPaused = false;
    resumeEngine();
  }

  void restartGame() {
    score.value = 0;
    lives.value = 5;
    GlobalState.isPaused = false;
    GlobalState.isPlayerBlocked = false;
    GlobalState.active = false;

    remove(gameplay);
    gameplay = Gameplay(
      onLevelCompleted: _handleLevelCompleted,
      onGameOver: _handleGameOver,
    );
    add(gameplay);
    resumeEngine();
  }

  void _handleLevelCompleted() {
    pauseEngine();
    if (onWinMethodCalled != null) {
      onWinMethodCalled!();
    } else {
      print("Win method not implemented");
    }
  }

  void _handleGameOver() {
    pauseEngine();
    if (onGameOverMethodCalled != null) {
      onGameOverMethodCalled!();
    } else {
      print("Game over method not implemented");
    }
  }
}
