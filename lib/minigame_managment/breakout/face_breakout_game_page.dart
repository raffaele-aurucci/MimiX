import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mimix_app/minigame_managment/breakout/src/breakout.dart';

import 'package:mimix_app/utils/view/app_palette.dart';

import 'package:mimix_app/expression_management/beans/expression_scores.dart';
import 'package:mimix_app/expression_management/view/web_view.dart';
import 'package:mimix_app/utils/view/widgets/alert_dialog.dart';
import 'package:mimix_app/utils/view/widgets/buttons/icon_button.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';
import 'package:mimix_app/utils/view/widgets/user_level.dart';

import 'package:mimix_app/utils/view/widgets/pause_menu.dart';
import 'package:provider/provider.dart';

import '../../user_management/beans/user_provider.dart';
import '../../utils/view/widgets/gameover_menu.dart';

class FaceBreakoutGamePage extends StatefulWidget {
  const FaceBreakoutGamePage({super.key});

  @override
  State<FaceBreakoutGamePage> createState() => _FaceBreakoutGamePageState();
}

class _FaceBreakoutGamePageState extends State<FaceBreakoutGamePage> {

  // instance of game
  late final Breakout game;

  // start game when camera is ready
  bool startGame = false;

  // save the local high score
  int highScore = 0;

  // using to hidden loading camera into webview
  bool _isOverlayVisible = true;

  // handle the overlay on camera webview
  void handleOverlay(bool hidden) {
    setState(() {
      _isOverlayVisible = hidden;
      if (startGame == false) {
        game.startGame();
        startGame = true;
      }
    });
  }

  void handleGameOver() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GameOverMenu(
            handleRestart: handleRestart,
            gameName: 'Game Over',
            quitNavigate: '/minigames_page',
          );
        },
      );
    });
  }

  void handleWon() {
    game.playState = PlayState.won;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GameOverMenu(
            handleRestart: handleRestart,
            gameName: 'You Won!',
            quitNavigate: '/minigames_page',
          );
        },
      );
    });
  }

  void handleResume() {
    if (game.playState == PlayState.isPaused) {
      game.resumeEngine();
      game.playState = PlayState.playing;
    }
  }

  void handleRestart() {
    game.resetGame();
  }

  void showPauseMenu(BuildContext context) {
    if (_isOverlayVisible == false) {
      game.playState = PlayState.isPaused;
      game.pauseEngine();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PauseMenu(
            handleResume: handleResume,
            handleRestart: handleRestart,
            gameName: 'Face Breakout',
            quitNavigate: '/minigames_page',
          );
        },
      );
    }
  }

  // handle face detected into webview
  bool _isFaceDetected = false;

  void handleFaceDetected(bool isFaceDetected) {
    if (!mounted) return;
    setState(() {
      _isFaceDetected = isFaceDetected;
    });
  }


  // handle expression scores from webview in order to manage input of game
  late ExpressionScores? _expressionScores;

  void handleExpressionScore(ExpressionScores? expressionScores) {
    _expressionScores = expressionScores;

    var mouthSmileLeft = _expressionScores!.getScore('mouthSmileLeft');
    var mouthSmileRight = _expressionScores!.getScore('mouthSmileRight');
    var mouthPucker = _expressionScores!.getScore('mouthPucker');

    if (mouthSmileLeft != null && mouthSmileRight != null && mouthPucker != null) {
      if (mouthSmileLeft > 0.7 && mouthSmileRight > 0.7
          && mouthPucker < mouthSmileLeft && mouthPucker < mouthSmileRight) {
        game.moveBatLeft();
      } else if (mouthPucker > 0.7 && mouthSmileLeft < mouthPucker
          && mouthSmileRight < mouthPucker) {
        game.moveBatRight();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    game = Breakout(handleGameOver: handleGameOver, handleWon: handleWon);
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
                children: [

                  // Pause button and profile level
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButtonWidget(
                              icon: Icons.pause_sharp,
                              onPressed: !_isOverlayVisible ? () {showPauseMenu(context);} : null
                          )
                        ],
                      ),
                      Column(
                        children: [
                          ProfileImageWithLevel(
                              experienceLevel: context.watch<UserProvider>().user!.level,
                              experienceProgress: context.watch<UserProvider>().user!.levelProgress + 0.2,
                              profileImage: const AssetImage('assets/images/icons/user.png'),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Legend of controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/emoticons/mouth_smile.png', width: 30, height: 30),
                              const SizedBox(width: 6),
                              Image.asset('assets/images/icons/left-arrow.png', width: 20, height: 20),
                              const HeaderText(text: ' Left', size: 20.0),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Image.asset('assets/images/emoticons/mouth_pucker.png', width: 30, height: 30),
                              const SizedBox(width: 6),
                              Image.asset('assets/images/icons/right-arrow.png', width: 20, height: 20),
                              const HeaderText(text: ' Right ', size: 20.0),
                            ],
                          ),
                        ],
                      ),

                      // Score
                      Column(
                        children: [
                          ValueListenableBuilder<int>(
                            valueListenable: game.score,
                            builder: (context, score, child) {
                              if (score > highScore) {
                                highScore = score;
                              }
                              return HeaderText(text: score.toString().padLeft(5, '0'), size: HeaderText.H4);
                            },
                          ),
                          const SizedBox(height: 0),
                          DescriptionText(text: 'HI ${highScore.toString().padLeft(5, '0')}', size: DescriptionText.P2)
                        ],
                      )
                    ],
                  ),

                  // Game
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                          color: const Color(0xFF586787),
                          border: Border.all(color: PaletteColor.darkBlue, width: 2)
                      ),
                      child: GameWidget.controlled(
                        gameFactory: () => game,
                      ),
                    ),
                  ),

                  // Webview
                  Container(
                      height: 130,
                      width: 100,
                      child: Stack(
                        children: [
                          WebView(
                            onExpressionScoresUpdated: handleExpressionScore,
                            onCameraHiddenUpdated: handleOverlay,
                            onFaceDetectedUpdated: handleFaceDetected,
                          ),

                          if (_isOverlayVisible)
                            Container(
                              color: Colors.white,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: PaletteColor.darkBlue,
                                ),
                              ),
                            ),
                        ],
                      )
                  ),
                ]
            ),
          ),
        )
      )
    );
  }
}