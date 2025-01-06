import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mimix_app/minigame_managment/dino_run/src/dino_run.dart';

import 'package:mimix_app/utils/view/app_palette.dart';

import 'package:mimix_app/expression_management/beans/expression_scores.dart';
import 'package:mimix_app/expression_management/view/web_view.dart';
import 'package:mimix_app/utils/view/widgets/alert_dialog.dart';
import 'package:mimix_app/utils/view/widgets/buttons/icon_button.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';
import 'package:mimix_app/utils/view/widgets/user_level.dart';

import 'package:mimix_app/utils/view/widgets/pause_menu.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../user_management/beans/user_provider.dart';

class FaceRunGamePage extends StatefulWidget {
  const FaceRunGamePage({super.key});

  @override
  State<FaceRunGamePage> createState() => _FaceRunGamePageState();
}

class _FaceRunGamePageState extends State<FaceRunGamePage> {

  // instance of game
  late final DinoRun game;

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
      DialogUtils.showErrorDialog(
          context: context,
          title: "Game Over",
          message: "Please try again.",
          buttonMessage: 'Restart',
          onTap: () {
            Navigator.of(context).pop();
            game.resetGame();
          }
      );
    });
  }

  void handleResume() {
    // Additional control is necessary when the pause occurs during the camera loading process.
    if (game.playState == PlayState.isPaused || game.playState == PlayState.playing) {
      game.resumeEngine();
      game.playState = PlayState.playing;
    }
  }

  void handleRestart() {
    game.resetGame();
  }

  void showPauseMenu(BuildContext context) {
    game.playState = PlayState.isPaused;
    game.pauseEngine();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PauseMenu(
            handleResume: handleResume,
            handleRestart: handleRestart,
            gameName: 'Face Run',
        );
      },
    );
  }

  // handle face detected into webview
  bool _isFaceDetected = false;

  void handleFaceDetected(bool isFaceDetected) {
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
    var jawOpen = _expressionScores!.getScore('jawOpen');

    if (mouthSmileLeft != null && mouthSmileRight != null && jawOpen != null) {
      if (mouthSmileLeft > 0.7 && mouthSmileRight > 0.7
          && jawOpen < mouthSmileLeft && jawOpen < mouthSmileRight) {
        game.jumpDino();
      } else if (jawOpen >= 0.5 && mouthSmileLeft < jawOpen
          && mouthSmileRight < jawOpen) {
        game.superJumpDino();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    game = DinoRun(handleGameOver: handleGameOver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              onPressed: () {
                                showPauseMenu(context);
                              }),
                        ],
                      ),
                      // TODO: update with user context
                      const Column(
                        children: [
                          ProfileImageWithLevel(
                              experienceLevel: 1,
                              experienceProgress: 0.2,
                              profileImage: AssetImage('assets/images/user.png'),
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              HeaderText(text: '😊', size: HeaderText.H4),
                              HeaderText(text: ' Jump', size: 20.0),
                            ],
                          ),
                          Row(
                            children: [
                              HeaderText(text: '😮', size: HeaderText.H4),
                              HeaderText(text: ' Super Jump', size: 20.0),
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
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      decoration: BoxDecoration(
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
    );
  }
}