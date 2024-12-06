import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class ProgressBar extends StatelessWidget {

  static const double smallCard = 7; // Width of progress bar in small cards
  static const double bigCard = 12; // Width of progress bar in big cards

  final double progress; // % progress of bar (double type)
  final double height;

  const ProgressBar({
    Key? key,
    required this.progress,
    required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // To edit
      decoration: BoxDecoration(
        color: PaletteColor.progressBarBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(16.0),
          value: progress,
          backgroundColor: PaletteColor.progressBarBackground,
          valueColor: AlwaysStoppedAnimation<Color>(
            PaletteColor.lightSkyBlue, // Colore di default della barra
          ),
        ),
      ),
    );
  }
}

//  CREATION EXAMPLE
//  ProgressBar(progress: 0.9),

// This snippet of code creates a progress bar with the progression of the bar relative to the value provided in input.