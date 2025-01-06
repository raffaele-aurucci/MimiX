import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/dino_run.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dino Run',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final DinoRun _dinoRun;

  void handleGameOver(){
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    _dinoRun = DinoRun(handleGameOver: handleGameOver);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dino Run'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: () {
              print(_dinoRun.playState);
              if (!(_dinoRun.playState == PlayState.isPaused)) {
                _dinoRun.playState = PlayState.isPaused;
                _dinoRun.pauseEngine();
              }
              else if (_dinoRun.playState == PlayState.isPaused) {
                _dinoRun.resumeEngine();
                _dinoRun.playState = PlayState.playing;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Overlay for score and lives
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display score
                ValueListenableBuilder<int>(
                  valueListenable: _dinoRun.score,  // Ascolta il punteggio
                  builder: (context, score, child) {
                    return Text(
                      'Score: $score',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                // Display lives
                ValueListenableBuilder<int>(
                  valueListenable: _dinoRun.lives,  // Ascolta le vite
                  builder: (context, lives, child) {
                    return Text(
                      'Lives: $lives',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Game
          Container(
            width: gameWidth, // Larghezza fissa
            height: gameHeight, // Altezza fissa
            margin: const EdgeInsets.fromLTRB(15, 50, 15, 50),
            child: GameWidget.controlled(
              gameFactory: () => _dinoRun,
            ),
          ),


          ElevatedButton(
            onPressed: () {
              print(_dinoRun.playState);

              _dinoRun.startGame();
              setState(() {});
            },
            child: const Text('Play'),
          ),

          // Display "Game Over"
          if (_dinoRun.playState == PlayState.gameOver)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Game Over',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _dinoRun.resetGame();
                      setState(() {});
                    },
                    child: const Text('Restart'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}