import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../expression_management/beans/expression_scores.dart';
import '../../expression_management/view/web_view.dart';
import '../../user_management/beans/user_provider.dart';
import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/pause_menu.dart';
import '../../utils/view/widgets/stopwatch.dart';
import '../../utils/view/widgets/texts/header_text.dart';
import '../../utils/view/widgets/training_progress_bar.dart';
import '../../utils/view/widgets/training_summary.dart';
import '../../utils/view/widgets/user_level.dart';


class TrainingSessionPage extends StatefulWidget {
  const TrainingSessionPage({super.key, required this.expression, required this.userLevel});

  final String expression;
  final int userLevel;

  @override
  State<TrainingSessionPage> createState() => _TrainingSessionPageState();
}

class _TrainingSessionPageState extends State<TrainingSessionPage> {

  late final StopwatchWidgetController _stopwatchController;

  int _GOAL = 0; // The goal to reach: the number of expression to replicate
  int _facialExpressionCount = 0; // Number of repetitions of the expression
  bool _isDone = false; // If the expression has been made
  bool _isPaused = false; // If the training is paused
  bool _goalSucces = false; // If the goal is achieved

  double _maxValueOfExpression = 0.0;

  bool _isOverlayVisible = true;
  bool _isFaceDetected = false;


  late ExpressionScores? _expressionScores;

  @override
  void initState() {
    super.initState();
    _GOAL = 5 * widget.userLevel;
  }

  void handleOverlay(bool hidden) {
    setState(() {
      _isOverlayVisible = hidden;
    });
  }

  // Flag to confirm face detection
  bool _confirmFaceDetection = false;
  Timer? _faceDetectionTimer;
  bool _isDoneCheckFaceDetect = false;

  void handleFaceDetected(bool isFaceDetected) {

    // Check isFaceDetected == true && preceded value == false && check not is done
    if (isFaceDetected && !_isFaceDetected && !_isDoneCheckFaceDetect) {

      _faceDetectionTimer?.cancel();

      // Set a timer for confirm face detection and check expressions
      _faceDetectionTimer = Timer(const Duration(milliseconds: 500), () {
        if (_isFaceDetected) {
          setState(() {
            _confirmFaceDetection = true;
            _isDoneCheckFaceDetect = true;
          });
        }
      });
    }
    // Check if isFaceDetected == false and preceded value == true
    else if (!isFaceDetected && _isFaceDetected) {
      setState(() {
        _confirmFaceDetection = false;
        _isDoneCheckFaceDetect = false;
      });
    }

    // Change value of _isFaceDetected
    setState(() {
      _isFaceDetected = isFaceDetected;
    });

    // The stopwatch starts when the face is detect and the goal is not reached.
    if (_isFaceDetected && !_goalSucces && !_isPaused){
      _stopwatchController.start();
    }
  }

  // If the user reach the goal of user level.
  void handleGoalSuccess(){
    if (_facialExpressionCount >= _GOAL) {
      showTrainingSummary();
      _goalSucces = true;
      _stopwatchController.stop();
    }
  }


  void handleExpressionScore(ExpressionScores? expressionScores) {
    _expressionScores = expressionScores;

    if (!_goalSucces && !_isPaused) {
      handleGoalSuccess();

      switch (widget.expression) {
        case "Mouth Smile":
          {
            var facialExpression1 = _expressionScores?.getScore(
                'mouthSmileLeft') ?? 0.0;
            var facialExpression2 = _expressionScores?.getScore(
                'mouthSmileRight') ?? 0.0;

            var avgOfValue = (facialExpression1 + facialExpression2) / 2;

            if (avgOfValue > _maxValueOfExpression) {
              _maxValueOfExpression =
                  double.parse(avgOfValue.toStringAsFixed(2));
            }

            if (facialExpression1 > 0.8 && facialExpression2 > 0.8 &&
                _confirmFaceDetection) {
              if (!_isDone) {
                _facialExpressionCount++;
                _isDone = true;
              }
            } else if (facialExpression1 < 0.8 && facialExpression2 < 0.8) {
              _isDone = false;
            }
          }

        case "Mouth Open":
          {
            var facialExpression = _expressionScores?.getScore('jawOpen') ??
                0.0;

            if (facialExpression > _maxValueOfExpression) {
              _maxValueOfExpression =
                  double.parse(facialExpression.toStringAsFixed(2));
            }


            if (facialExpression > 0.65 && _confirmFaceDetection) {
              if (!_isDone) {
                _facialExpressionCount++;
                _isDone = true;
              }
            } else if (facialExpression < 0.65) {
              _isDone = false;
            }
          }

        case "Mouth Pucker":
          {
            var facialExpression = _expressionScores?.getScore('mouthPucker') ??
                0.0;

            if (facialExpression > _maxValueOfExpression) {
              _maxValueOfExpression =
                  double.parse(facialExpression.toStringAsFixed(2));
            }

            if (facialExpression > 0.95 && _confirmFaceDetection) {
              if (!_isDone) {
                _facialExpressionCount++;
                _isDone = true;
              }
            } else if (facialExpression < 0.1) {
              _isDone = false;
            }
          }

        case "Brow Up":
          {
            var facialExpression1 = _expressionScores?.getScore(
                'browOuterUpLeft') ?? 0.0;
            var facialExpression2 = _expressionScores?.getScore(
                'browOuterUpRight') ?? 0.0;

            var avgOfValue = (facialExpression1 + facialExpression2) / 2;

            if (avgOfValue > _maxValueOfExpression) {
              _maxValueOfExpression =
                  double.parse(avgOfValue.toStringAsFixed(2));
            }

            if (facialExpression1 > 0.7 && facialExpression2 > 0.7 &&
                _confirmFaceDetection) {
              if (!_isDone) {
                _facialExpressionCount++;
                _isDone = true;
              }
            } else if (facialExpression1 < 0.7 && facialExpression2 < 0.7) {
              _isDone = false;
            }
          }

        case "Brow Down":
          {
            var facialExpression1 = _expressionScores?.getScore(
                'browDownLeft') ?? 0.0;
            var facialExpression2 = _expressionScores?.getScore(
                'browDownRight') ?? 0.0;

            var avgOfValue = (facialExpression1 + facialExpression2) / 2;

            if (avgOfValue > _maxValueOfExpression) {
              _maxValueOfExpression =
                  double.parse(avgOfValue.toStringAsFixed(2));
            }

            if (facialExpression1 > 0.25 && facialExpression2 > 0.25 &&
                _confirmFaceDetection) {
              if (!_isDone) {
                _facialExpressionCount++;
                _isDone = true;
              }
            } else if (facialExpression1 < 0.25 && facialExpression2 < 0.25) {
              _isDone = false;
            }
          }

        case "Mouth Lower":
          {

            var facialExpression = _expressionScores?.getScore(
                'mouthShrugLower') ?? 0.0;
            print('mouthLower $facialExpression');
            if (facialExpression > _maxValueOfExpression) {
              _maxValueOfExpression =
                  double.parse(facialExpression.toStringAsFixed(2));
            }

            if (facialExpression > 0.65 && _confirmFaceDetection) {
              if (!_isDone) {
                _facialExpressionCount++;
                _isDone = true;
              }
            } else if (facialExpression < 0.65) {
              _isDone = false;
            }
          }
      }
    }
  }

  void handleResume(){
    _stopwatchController.start();
    _isPaused = false;
  }

  void handleRestart(){
    _stopwatchController.reset();
    _goalSucces = false;
    _isPaused = false;
    _facialExpressionCount = 0;
  }

  void showTrainingSummary() {
    // Stop the stopwatch
    _stopwatchController.stop();

    // Show alertDialog with training information
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return TrainingSummary(
          expression: widget.expression,
          time: _stopwatchController.elapsed(),
          maxValueForExpression: _maxValueOfExpression,
          handleRestart: handleRestart,
        );
      },
    );
  }

  void showPauseMenu(BuildContext context) {
    _isPaused = true;
    _stopwatchController.stop();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PauseMenu(
          handleResume: handleResume,
          handleRestart: handleRestart,
          gameName: widget.expression,
          quitNavigate: '/training_page',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
        canPop: false,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
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

                  HeaderText(text: widget.expression, size: HeaderText.H3),

                  const SizedBox(height: 20),

                  // WebView
                  Container(
                    height: screenHeight * 0.39,
                    width: screenWidth * 0.65,
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
                    ),
                  ),

                  const SizedBox(height: 30),

                  const HeaderText(text: 'Keep going!', size: HeaderText.H4),

                  const SizedBox(height: 10),

                  Container(
                    width: screenWidth * 0.65,
                    child: TrainingProgressBar(
                      progress: _facialExpressionCount / _GOAL,
                      height: TrainingProgressBar.trainingBar,
                      expressionCount: _facialExpressionCount,
                    ),
                  ),

                  const SizedBox(height: 70),

                  // Stopwatch controller
                  StopwatchWidget(
                    onControllerReady: (controller) {
                      _stopwatchController = controller;
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
