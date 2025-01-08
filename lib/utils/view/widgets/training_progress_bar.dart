import 'package:flutter/material.dart';

import '../app_palette.dart';

class TrainingProgressBar extends StatelessWidget {

  static const double smallCard = 7; // Width of progress bar in small cards
  static const double bigCard = 12; // Width of progress bar in big cards
  static const double trainingBar = 24; // Width of progress bar in training session page

  final double progress; // % progress of bar (double type)
  final double height;
  final int expressionCount; // Number of repetitions of the expression

  const TrainingProgressBar({
    Key? key,
    required this.progress,
    required this.height,
    required this.expressionCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft, // Align content to the left
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: PaletteColor.progressBarBackground,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: PaletteColor.progressBarBackground,
              valueColor: const AlwaysStoppedAnimation<Color>(
                PaletteColor.lightSkyBlue,
              ),
            ),
          ),
        ),

        // Overlapping text positioned at the beginning.
        Padding(
          padding: const EdgeInsets.only(left: 0.0), // Distance from left side
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: PaletteColor.darkBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '$expressionCount',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//  CREATION EXAMPLE
//  ProgressBar(progress: 0.9),

// This snippet of code creates a progress bar with the progression of the bar relative to the value provided in input.