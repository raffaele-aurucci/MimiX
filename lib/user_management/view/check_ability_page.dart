import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mimix_app/user_management/logic/user_logic.dart';
import 'package:provider/provider.dart';

import '../../expression_management/beans/expression_scores.dart';
import '../../expression_management/view/web_view.dart';
import '../../user_management/beans/user_provider.dart';
import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/texts/header_text.dart';
import '../../utils/view/widgets/training_progress_bar.dart';
import 'menu_page.dart';


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
    "Brow Up",
    "Brow Down",
  ];

  List<Map<String, double>> expressionAvgScores = [
    {"mouthSmileLeft": 0.0},
    {"mouthSmileRight": 0.0},
    {"jawOpen": 0.0},
    {"mouthPucker": 0.0},
    {"browOuterUpLeft": 0.0},
    {"browOuterUpRight": 0.0},
    {"browDownLeft": 0.0},
    {"browDownRight": 0.0},
  ];

  List<String> emojiImagePath = [
    'assets/images/emoticons/mouth_smile.png',
    'assets/images/emoticons/mouth_open.png',
    'assets/images/emoticons/mouth_pucker.png',
    'assets/images/emoticons/brow_up.png',
    'assets/images/emoticons/brow_down.png',
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
  }

  bool _isDone = false;

  void handleExpressionScore(ExpressionScores? expressionScores) {
    _expressionScores = expressionScores;

    var mouthSmileLeft = _expressionScores!.getScore('mouthSmileLeft');
    var mouthSmileRight = _expressionScores!.getScore('mouthSmileRight');
    var jawOpen = _expressionScores!.getScore('jawOpen');
    var mouthPucker = _expressionScores!.getScore('mouthPucker');
    var browDownLeft = _expressionScores!.getScore('browDownLeft');
    var browDownRight = _expressionScores!.getScore('browDownRight');
    var browOuterUpLeft = _expressionScores!.getScore('browOuterUpLeft');
    var browOuterUpRight = _expressionScores!.getScore('browOuterUpRight');

    if (_facialExpressionCount == _GOAL) {
      handleNext();
      return;
    }

    switch(expressions[_indexCheckedExpression]) {

      case "Mouth Smile":
        {

          if (mouthSmileLeft != null && mouthSmileRight != null) {
            if (mouthSmileLeft > 0.9 && mouthSmileRight > 0.9 && _confirmFaceDetection) {

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

            } else if (mouthSmileLeft < 0.9 && mouthSmileRight < 0.9){
              _isDone = false;
            }
          }
        }

      case "Mouth Open": {

        if (jawOpen != null) {

          if (jawOpen > 0.6 && _confirmFaceDetection) {
            if (!_isDone) {
              _facialExpressionCount += 1;
              expressionAvgScores[2]['jawOpen'] = incrementalAvg(
                  expressionAvgScores[2]['jawOpen']!,
                  jawOpen,
                  _facialExpressionCount);
              _isDone = true;
            }
          } else if (jawOpen < 0.6) {
            _isDone = false;
          }
        }
      }

      case "Mouth Pucker": {

        if (mouthPucker != null) {

          if (mouthPucker > 0.9 && _confirmFaceDetection) {
            if (!_isDone) {
              _facialExpressionCount += 1;
              expressionAvgScores[3]['mouthPucker'] = incrementalAvg(
                  expressionAvgScores[3]['mouthPucker']!,
                  mouthPucker,
                  _facialExpressionCount);
              _isDone = true;
            }
          } else if (mouthPucker < 0.05){
            _isDone = false;
          }
        }
      }

      case "Brow Up": {

        if (browOuterUpLeft != null && browOuterUpRight != null){
          if (browOuterUpLeft > 0.7 && browOuterUpRight > 0.7 && _confirmFaceDetection){

            if (!_isDone) {
              _facialExpressionCount += 1;
              expressionAvgScores[4]['browOuterUpLeft'] = incrementalAvg(
                  expressionAvgScores[4]['browOuterUpLeft']!,
                  browOuterUpLeft,
                  _facialExpressionCount);
              expressionAvgScores[5]['browOuterUpRight'] = incrementalAvg(
                  expressionAvgScores[5]['browOuterUpRight']!,
                  browOuterUpRight,
                  _facialExpressionCount);
              _isDone = true;
            }
          } else if (browOuterUpLeft < 0.7 && browOuterUpRight < 0.7){
            _isDone = false;
          }
        }

      }

      case "Brow Down": {

        if (browDownLeft != null && browDownRight != null){
          if (browDownLeft > 0.3 && browDownRight > 0.3 && _confirmFaceDetection){

            if (!_isDone){
              _facialExpressionCount += 1;
              expressionAvgScores[6]['browDownLeft'] = incrementalAvg(
                  expressionAvgScores[6]['browDownLeft']!,
                  browDownLeft,
                  _facialExpressionCount);
              expressionAvgScores[7]['browDownRight'] = incrementalAvg(
                  expressionAvgScores[7]['browDownRight']!,
                  browDownRight,
                  _facialExpressionCount);
              _isDone = true;
            }
          } else if (browDownLeft < 0.3 && browDownRight < 0.3){
            _isDone = false;
          }
        }
      }

    }
  }


  Future<void> handleNext() async {

    setState(() {
      _facialExpressionCount = 0;
      _isDone = false;
    });

    if (_indexCheckedExpression < 4) {
      _indexCheckedExpression += 1;
    }

    else if (_indexCheckedExpression == 4){
      bool? isCheckInserted = await insertCheckAbilityByUserId(expressionAvgScores, context.read<UserProvider>().user!.id!);

      if (isCheckInserted != null && isCheckInserted) {
        print("Check ability inserted succesfully.");
      } else {
        print("Check ability failed.");
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
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

                    Spacer(),

                    // HeaderText(
                    //   text: emojiExpression[_indexCheckedExpression],
                    //   size: 45,
                    // ),
                    Image.asset(emojiImagePath[_indexCheckedExpression], scale: 5,),

                    Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: index == _indexCheckedExpression ? PaletteColor.darkBlue : PaletteColor.progressBarBackground, // Cambia colore se attivo
                            shape: BoxShape.circle,
                            border: index != _indexCheckedExpression ? Border.all( // Bordo aggiunto
                              color: Colors.black,
                              width: 0.01,
                            ) : null
                          ),
                        );
                      }),
                    )
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
