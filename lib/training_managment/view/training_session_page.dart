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

  int _goal = 0; // The goal to reach: the number of expression to replicate
  int _facialExpressionCount = 0; // Number of repetitions of the expression
  bool _isDone = false; // If the expression has been made
  bool _isPaused = false; // If the training is paused
  bool _goalSucces = false; // If the goal is achieved

  // If there is a single expression (mouth open) or two expressions (brow up left and right) to manage
  int _numberOfExpressionToTraining = 0;

  double _maxValueOfExpression = 0.0;

  bool _isOverlayVisible = true;
  bool _isFaceDetected = false;

  String firstExpression = "";
  String secondExpression = "";

  late ExpressionScores? _expressionScores;

  @override
  void initState() {
    super.initState();

    // It checks the value passed to the page: if it is composed from one or two expressions.
    _checkExpression(widget.expression);
    _goal = 5 * widget.userLevel;
  }

  void handleOverlay(bool hidden) {
    setState(() {
      _isOverlayVisible = hidden;
    });
  }

  void handleFaceDetected(bool isFaceDetected) {
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
    if (_facialExpressionCount >= _goal) {
      showTrainingSummary(); // Mostra l'AlertDialog
      _goalSucces = true;
      _stopwatchController.stop();
    }
  }

  void handleExpressionScore(ExpressionScores? expressionScores) {
    _expressionScores = expressionScores;

    if(!_goalSucces && _numberOfExpressionToTraining != 0 && !_isPaused) {
      handleGoalSuccess();

      if (_numberOfExpressionToTraining == 1) {
        // Get the value of the expression
        var facialExpression = _expressionScores?.getScore(firstExpression) ?? 0.0;

        if(facialExpression > _maxValueOfExpression)
          _maxValueOfExpression = double.parse(facialExpression.toStringAsFixed(2));

        if (facialExpression > 0.50) {
          if (!_isDone) {
            _facialExpressionCount++;
            _isDone = true;
          }
        } else {
          _isDone = false;
        }
      } else {
        var facialExpression1 = _expressionScores?.getScore(firstExpression) ?? 0.0;
        var facialExpression2 = _expressionScores?.getScore(secondExpression) ?? 0.0;

        var avgOfValue = (facialExpression1 + facialExpression2)/2;

        if(avgOfValue > _maxValueOfExpression)
          _maxValueOfExpression = double.parse(avgOfValue.toStringAsFixed(2));

        if (facialExpression1 > 0.50 && facialExpression2 > 0.50) {
          if (!_isDone) {
            _facialExpressionCount++;
            _isDone = true; // The expression is done and it's not possible overlap
          }
        } else {
          _isDone = false; //
        }
      }
    }
  }

  // Check the value passed to the page
  void _checkExpression(String expression) {
    if (expression == "Mouth Open") {
      firstExpression = "jawOpen";
      _numberOfExpressionToTraining = 1;
    }
    if (expression == "Mouth Pucker") {
      firstExpression = "mouthPucker";
      _numberOfExpressionToTraining = 1;
    }
    if (expression == "Mouth Lower") {
      firstExpression = "mouthShrugLower";
      _numberOfExpressionToTraining = 1;
    }
    if (expression == "Brow Down") {
      firstExpression = "browDownLeft";
      secondExpression = "browDownRight";
      _numberOfExpressionToTraining = 2;
    }
    if (expression == "Brow Up") {
      firstExpression = "browOuterUpLeft";
      secondExpression = "browOuterUpRight";
      _numberOfExpressionToTraining = 2;
    }
    if (expression == "Mouth Smile") {
      firstExpression = "mouthSmileLeft";
      secondExpression = "mouthSmileRight";
      _numberOfExpressionToTraining = 2;
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

    return Scaffold(
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
                        profileImage: const AssetImage('assets/images/user.png'),
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
                height: screenHeight * 0.4,
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
                  progress: _facialExpressionCount / _goal,
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
    );
  }
}
