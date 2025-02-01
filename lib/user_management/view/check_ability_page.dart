import 'package:flutter/material.dart';
import 'package:mimix_app/user_management/logic/user_logic.dart';
import 'package:mimix_app/user_management/view/home_page.dart';
import 'package:mimix_app/utils/view/widgets/buttons/next_button.dart';
import 'package:mimix_app/utils/view/widgets/buttons/secondary_button.dart';
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


class CheckAbilityPage extends StatefulWidget {
  const CheckAbilityPage({super.key});

  @override
  State<CheckAbilityPage> createState() => _CheckAbilityPageState();
}

class _CheckAbilityPageState extends State<CheckAbilityPage> {

  final int _GOAL = 3;
  int _facialExpressionCount = 0;

  bool _isOverlayVisible = true;
  bool _isFaceDetected = false;

  int _indexCheckedExpression = 0;

  List<String> expressions = [
    "Mouth Smile",
    "Mouth Open",
    "Mouth Pucker",
    "Mouth Lower",
    "Brow Up",
    "Brow Down",
  ];

  List<Map<String, double>> expressionAvgScores = [
    {"mouthSmileLeft": 0.0},
    {"mouthSmileRight": 0.0},
    {"jawOpen": 0.0},
    {"mouthPucker": 0.0},
    {"mouthShrugLower": 0.0},
    {"browOuterUpLeft": 0.0},
    {"browOuterUpRight": 0.0},
    {"browDownLeft": 0.0},
    {"browDownRight": 0.0},
  ];

  List<String> emojiExpression = [
    '😊',
    '😮',
    '😚',
    '🙁',
    '🤨',
    '😣'
  ];


  late ExpressionScores? _expressionScores;

  @override
  void initState() {
    super.initState();
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
  }

  bool _isDone = false;

  void handleExpressionScore(ExpressionScores? expressionScores) {
    _expressionScores = expressionScores;

    var mouthSmileLeft = _expressionScores!.getScore('mouthSmileLeft');
    var mouthSmileRight = _expressionScores!.getScore('mouthSmileRight');
    var jawOpen = _expressionScores!.getScore('jawOpen');
    var mouthPucker = _expressionScores!.getScore('mouthPucker');
    var mouthShrugLower = _expressionScores!.getScore('mouthShrugLower');
    var browDownLeft = _expressionScores!.getScore('browDownLeft');
    var browDownRight = _expressionScores!.getScore('browDownRight');
    var browOuterUpLeft = _expressionScores!.getScore('browOuterUpLeft');
    var browOuterUpRight = _expressionScores!.getScore('browOuterUpRight');


    switch(expressions[_indexCheckedExpression]) {

      case "Mouth Smile":
        {
          if (_facialExpressionCount == _GOAL) return;

          if (mouthSmileLeft != null && mouthSmileRight != null) {
            if (mouthSmileLeft > 0.5 && mouthSmileRight > 0.5) {

              if (!_isDone) {
                _facialExpressionCount += 1;
                // Incremental average AI ;
                expressionAvgScores[0]['mouthSmileLeft'] = incrementalAvg(
                    expressionAvgScores[0]['mouthSmileLeft']!,
                    mouthSmileLeft,
                    _facialExpressionCount);

                expressionAvgScores[1]['mouthSmileRight'] = incrementalAvg(
                    expressionAvgScores[1]['mouthSmileRight']!,
                    mouthSmileRight,
                    _facialExpressionCount);

                _isDone = true;
              }

            } else {
              _isDone = false;
            }
          }
        }

      case "Mouth Open": {

        if (_facialExpressionCount == _GOAL) return;

        if (jawOpen != null) {
          if (jawOpen > 0.5) {
            if (!_isDone) {
              _facialExpressionCount += 1;
              expressionAvgScores[2]['jawOpen'] = incrementalAvg(
                  expressionAvgScores[2]['jawOpen']!,
                  jawOpen,
                  _facialExpressionCount);
              _isDone = true;
            }
          } else {
            _isDone = false;
          }
        }
      }

      case "Mouth Pucker": {

        if (_facialExpressionCount == _GOAL) return;

        if (mouthPucker != null) {
          if (mouthPucker > 0.5) {
            if (!_isDone) {
              _facialExpressionCount += 1;
              expressionAvgScores[3]['mouthPucker'] = incrementalAvg(
                  expressionAvgScores[3]['mouthPucker']!,
                  mouthPucker,
                  _facialExpressionCount);
              _isDone = true;
            }
          } else {
            _isDone = false;
          }
        }
      }

      case "Mouth Lower": {

        if (_facialExpressionCount == _GOAL) return;

        if (mouthShrugLower != null) {
          if (mouthShrugLower > 0.5) {

            if (!_isDone) {
              _facialExpressionCount += 1;
              expressionAvgScores[4]['mouthShrugLower'] = incrementalAvg(
                  expressionAvgScores[4]['mouthShrugLower']!,
                  mouthShrugLower,
                  _facialExpressionCount);
            }
            _isDone = true;
          }
          else {
            _isDone = false;
          }
        }

      }

      case "Brow Up": {

        if (_facialExpressionCount == _GOAL) return;

        if (browOuterUpLeft != null && browOuterUpRight != null){
          if (browOuterUpLeft > 0.5 && browOuterUpRight > 0.5){

            if (!_isDone) {
              _facialExpressionCount += 1;
              expressionAvgScores[5]['browOuterUpLeft'] = incrementalAvg(
                  expressionAvgScores[5]['browOuterUpLeft']!,
                  browOuterUpLeft,
                  _facialExpressionCount);
              expressionAvgScores[6]['browOuterUpRight'] = incrementalAvg(
                  expressionAvgScores[6]['browOuterUpRight']!,
                  browOuterUpRight,
                  _facialExpressionCount);
              _isDone = true;
            }
            else {
              _isDone = false;
            }
          }
        }

      }

      case "Brow Down": {

        if (_facialExpressionCount == _GOAL) return;

        if (browDownLeft != null && browDownRight != null){
          if (browDownLeft > 0.5 && browDownRight > 0.5){

            if (!_isDone){
              _facialExpressionCount += 1;
              expressionAvgScores[7]['browDownLeft'] = incrementalAvg(
                  expressionAvgScores[7]['browDownLeft']!,
                  browDownLeft,
                  _facialExpressionCount);
              expressionAvgScores[8]['browDownRight'] = incrementalAvg(
                  expressionAvgScores[8]['browDownRight']!,
                  browDownRight,
                  _facialExpressionCount);
              _isDone = true;
            }
          } else {
            _isDone = false;
          }
        }

      }

    }

  }

  Future<void> handleNextButton() async {

    _facialExpressionCount = 0;
    _isDone = false;

    if (_indexCheckedExpression < 5) {
      _indexCheckedExpression += 1;
    }

    else if (_indexCheckedExpression == 5){
      bool? isCheckInserted = await insertCheckAbilityByUserId(expressionAvgScores, context.read<UserProvider>().user!.id!);

      if (isCheckInserted != null && isCheckInserted) {
        print("Check ability inserted succesfully.");
      } else {
        print("Check ability failed.");
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

      // TODO: go to let's get started
    }
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

              const SizedBox(height: 30),

              const HeaderText(text: "Check your ability", size: HeaderText.H3),

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

              HeaderText(text: expressions[_indexCheckedExpression], size: HeaderText.H4),

              const SizedBox(height: 10),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth * 0.65,
                      child: TrainingProgressBar(
                        progress: _facialExpressionCount / _GOAL,
                        height: TrainingProgressBar.trainingBar,
                        expressionCount: _facialExpressionCount,
                      ),
                    ),

                    Spacer(), // Ora funziona perché la Column è in un Expanded

                    HeaderText(
                      text: emojiExpression[_indexCheckedExpression],
                      size: 45,
                    ),

                    Spacer(),

                    NextButton(
                      text: 'Next',
                      onPressed: _facialExpressionCount == _GOAL ? handleNextButton : null,
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
