import 'package:flutter/material.dart';

import '../../app_palette.dart';
import '../circular_progress_bar.dart';
import '../texts/description_text.dart';
import '../texts/header_text.dart';

class GeneralTaskCard extends StatelessWidget{

  final int experienceLevel;
  final double experienceProgress;
  final double firstProgress;
  final String firstTaskName;
  final double secondProgress;
  final String secondTaskName;
  final double thirdProgress;
  final String thirdTaskName;

  const GeneralTaskCard({
    Key? key,
    required this.experienceLevel,
    required this.experienceProgress,
    required this.firstProgress,
    required this.firstTaskName,
    required this.secondProgress,
    required this.secondTaskName,
    required this.thirdProgress,
    required this.thirdTaskName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: PaletteColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular bar progress of user level
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(120, 120),
                  painter: CircularProgressBar(
                      progress: experienceProgress,
                      strokeWidth: 10
                  ),
                ),
                HeaderText(
                  text: experienceLevel.toString(),
                  size: HeaderText.H3,
                ),
              ],
            ),
            const SizedBox(width: 30),
            // The last three best task about their progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First circular progress bar for task
                Row(
                  children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(25, 25),
                            painter: CircularProgressBar(
                                progress: firstProgress,
                                strokeWidth: 2.5
                            ),
                          ),
                          Icon(
                            Icons.check,
                            size: 14,
                            // If the task is completed then the check icon turns blue, otherwise it is grey
                            color: firstProgress == 1 ? PaletteColor.darkBlue : PaletteColor.progressBarBackground,
                          ),
                        ],
                      ),
                    const SizedBox(width: 10),
                    DescriptionText(text: firstTaskName, size: DescriptionText.P2)
                  ],
                ),
                const SizedBox(height: 20),
                // Second circular progress bar for task
                Row(
                  children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(25, 25),
                            painter: CircularProgressBar(
                                progress: secondProgress,
                                strokeWidth: 2.5
                            ),
                          ),
                          Icon(
                            Icons.check,
                            size: 14,
                            // If the task is completed then the check icon turns blue, otherwise it is grey
                            color: secondProgress == 1 ? PaletteColor.darkBlue : PaletteColor.progressBarBackground,
                          ),
                        ],
                      ),
                    const SizedBox(width: 10),
                    DescriptionText(text: secondTaskName, size: DescriptionText.P2)
                  ],
                ),
                const SizedBox(height: 20),
                // Third circular progress bar for task
                Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(25, 25),
                            painter: CircularProgressBar(
                                progress: thirdProgress,
                                strokeWidth: 2.5
                            ),
                          ),
                          Icon(
                            Icons.check,
                            size: 14,
                            // If the task is completed then the check icon turns blue, otherwise it is grey
                            color: thirdProgress == 1 ? PaletteColor.darkBlue : PaletteColor.progressBarBackground,
                          ),
                        ],
                      ),
                    const SizedBox(width: 10),
                    DescriptionText(text: thirdTaskName, size: DescriptionText.P2)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

