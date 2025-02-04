import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/game.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/globals.dart';

import 'package:mimix_app/utils/view/app_palette.dart';

import 'package:mimix_app/expression_management/beans/expression_scores.dart';
import 'package:mimix_app/expression_management/view/web_view.dart';
import 'package:mimix_app/utils/view/widgets/buttons/icon_button.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';
import 'package:mimix_app/utils/view/widgets/user_level.dart';

import 'package:mimix_app/utils/view/widgets/pause_menu.dart';
import 'package:provider/provider.dart';

import '../../user_management/beans/user_provider.dart';
import '../../utils/view/widgets/gameover_menu.dart';

class FaceSkiGamePage extends StatefulWidget {
  const FaceSkiGamePage({super.key});

  @override
  State<FaceSkiGamePage> createState() => _FaceSkiGamePageState();
}

class _FaceSkiGamePageState extends State<FaceSkiGamePage> {

  // instance of game
  late final FaceSkiGame game;

  // save the local high score
  int highScore = 0;

  // using to hidden loading camera into webview
  bool _isOverlayVisible = true;

  // handle the overlay on camera webview
  void handleOverlay(bool hidden) {
    setState(() {
      _isOverlayVisible = hidden;
      if (GlobalState.startGame == false) {
        game.startGame();
        GlobalState.startGame = true;
      }else{
        game.startGame();
      }
    });
  }

  void handleResume() {
    setState(() {
      game.resumeGame();
    });
  }


  void handleRestart() {
    setState(() {
      game.restartGame();
    });
  }

  void showPauseMenu(BuildContext context) {
    if (_isOverlayVisible == false) {
      GlobalState.isPaused = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PauseMenu(
            handleResume: handleResume,
            handleRestart: handleRestart,
            gameName: 'Face Ski',
            quitNavigate: '/minigames_page',
          );
        },
      );
    }
  }


  void handleFaceDetected(bool isFaceDetected) {
    if (!mounted) return;
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
        game.gameplay.turnLeft();
      } else if (jawOpen >= 0.5 && mouthSmileLeft < jawOpen
          && mouthSmileRight < jawOpen) {
        game.gameplay.turnRight();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    game = FaceSkiGame(onGameOverMethodCalled: showGameOverMenu);
  }

  void showGameOverMenu() {
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
                              onPressed: !_isOverlayVisible ? () {showPauseMenu(context);} : null
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          ProfileImageWithLevel(
                            experienceLevel: context.watch<UserProvider>().user!.level,
                            experienceProgress: context.watch<UserProvider>().user!.levelProgress + 0.2,
                            profileImage: const AssetImage('assets/images/user.png'),
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
                              HeaderText(text: ' Right', size: 20.0),
                            ],
                          ),
                          Row(
                            children: [
                              HeaderText(text: '😮', size: HeaderText.H4),
                              HeaderText(text: ' Left', size: 20.0),
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
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15), // Margini opzionali
                      decoration: BoxDecoration(
                        border: Border.all(color: PaletteColor.darkBlue, width: 2),
                      ),
                      child: GameWidget(
                        game: game,
                      )
                    ),
                  ),

                  // Webview
                  SizedBox(
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
