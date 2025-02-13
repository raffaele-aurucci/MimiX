import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class ProgressBar extends StatelessWidget {

  static const double heightSmallCard = 7; // Height of progress bar in small cards
  static const double heightBigCard = 12; // Height of progress bar in big cards
  static const double statsProgressBarWidth = 150; // Width of progress bar for stats page
  static const String vertical = "vertical"; // Vertical orientation of progress bar
  static const String horizontal = "horizontal"; // Horizontal orientation of progress bar

  final double progress; // % progress of bar (double type)
  final double height;
  final double? width;
  final String orientation;

  const ProgressBar({
    Key? key,
    required this.progress,
    required this.height,
    this.width,
    required this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(orientation == horizontal) {
      return Container(
        height: height, // TODO: remove fixed height
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
            valueColor: const AlwaysStoppedAnimation<Color>(
              PaletteColor.lightSkyBlue,
            ),
          ),
        ),
      );
    } else {
      return RotatedBox(
        quarterTurns: -1,
        child: Container(
          height: height, // TODO: remove fixed height
          width: MediaQuery.of(context).size.width * 0.6,
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
              valueColor: const AlwaysStoppedAnimation<Color>(
                PaletteColor.lightSkyBlue,
              ),
            ),
          ),
        ),
      );
    }
  }
}