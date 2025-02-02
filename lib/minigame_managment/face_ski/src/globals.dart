import 'dart:async';

class GlobalState {
  static double playerOrientation = 0.0;
  static bool active = false;
  static bool isPaused = false;
}

class PlayerController {
  Timer? _resetTimer;

  void _startResetTimer() {
    // Cancella il timer precedente, se esiste
    _resetTimer?.cancel();

    // Crea un nuovo timer che resetta l'orientamento dopo un secondo
    _resetTimer = Timer(Duration(milliseconds: 120), () {
      GlobalState.playerOrientation = 0.0;
    });
  }

  void turnLeft() {
    GlobalState.playerOrientation = 1.0;
    _startResetTimer();  // Avvia o riavvia il timer
  }

  void turnRight() {
    GlobalState.playerOrientation = -1.0;
    _startResetTimer();  // Avvia o riavvia il timer
  }
}

