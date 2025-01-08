import 'package:flutter/material.dart';

import '../../expression_management/beans/expression_scores.dart';
import '../../expression_management/view/web_view.dart';
import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/stopwatch.dart';
import '../../utils/view/widgets/texts/header_text.dart';
import '../../utils/view/widgets/training_progress_bar.dart';
import '../../utils/view/widgets/training_summary.dart';


class TrainingSessionPage extends StatefulWidget {
  const TrainingSessionPage({super.key, required this.expression});

  final String expression;

  @override
  State<TrainingSessionPage> createState() => _TrainingSessionPageState();
}

class _TrainingSessionPageState extends State<TrainingSessionPage> {
  late final StopwatchWidgetController _stopwatchController;

  // '1' will change with user level
  int _goal = (5 * (1)); // The goal to reach: the number of expression to replicate
  int _facialExpressionCount = 0; // Number of repetitions of the expression
  bool _isDone = false; // If the expression has been made
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
    if (_isFaceDetected && !_goalSucces) {
      _stopwatchController.start();
    }
  }

  // If the user reach the goal of user level.
  void handleGoalSuccess(){
    if (_facialExpressionCount >= _goal) {
      _showTrainingSummary(); // Mostra l'AlertDialog
      _goalSucces = true;
      _stopwatchController.stop();
    }
  }

  void handleExpressionScore(ExpressionScores? expressionScores) {
    _expressionScores = expressionScores;

    if(!_goalSucces && _numberOfExpressionToTraining != 0) {
      handleGoalSuccess();

      if (_numberOfExpressionToTraining == 1) {
        // Get the value of the expression
        var facialExpression = _expressionScores?.getScore(firstExpression) ?? 0.0;

        if(facialExpression > _maxValueOfExpression)
          _maxValueOfExpression = double.parse(facialExpression.toStringAsFixed(2));;

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
      firstExpression = "browDownRight";
      _numberOfExpressionToTraining = 2;
    }
    if (expression == "Brow Up") {
      firstExpression = "browOuterUpLeft";
      firstExpression = "browOuterUpRight";
      _numberOfExpressionToTraining = 2;
    }
    if (expression == "Mouth Smile") {
      firstExpression = "mouthSmileLeft";
      firstExpression = "mouthSmileRight";
      _numberOfExpressionToTraining = 2;
    }
  }

  void handleRestart(){
    _stopwatchController.reset();
    _goalSucces = false;
    _facialExpressionCount = 0;
  }

  void _showTrainingSummary() {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButtonWidget(
            icon: Icons.arrow_back,
            onPressed: !_isOverlayVisible ? () {Navigator.pop(context);} : null
        ),
      ),
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              HeaderText(text: widget.expression, size: HeaderText.H3),
              SizedBox(height: 20),

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
                width: screenWidth * 0.6,
                child: TrainingProgressBar(
                  progress: _facialExpressionCount / _goal,
                  height: TrainingProgressBar.trainingBar,
                  expressionCount: _facialExpressionCount,
                ),
              ),

              const SizedBox(height: 100),

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
