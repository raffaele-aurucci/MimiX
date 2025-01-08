import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';

import '../app_palette.dart';
import 'buttons/primary_button.dart';
import 'buttons/secondary_button.dart';



class TrainingSummary extends StatelessWidget {

  final String expression;
  final String time;
  final double maxValueForExpression;
  final Function() handleRestart;

  const TrainingSummary({
    super.key,
    required this.expression,
    required this.time,
    required this.maxValueForExpression,
    required this.handleRestart,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      title: const Row(
        children: [
          Icon(Icons.check_circle_outline, color: PaletteColor.darkBlue, size: 28),

          SizedBox(width: 10),

          HeaderText(
            text: "Training Summary",
            size: HeaderText.H4,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(color: PaletteColor.darkBlue, thickness: 1), // Dividing line

          const SizedBox(height: 8),

          // Name of the trained expression.
          DescriptionText(
            text: "Trained expression: $expression",
            size: DescriptionText.P2,
          ),

          const SizedBox(height: 8),

          // Time needed to achieve the goal.
          DescriptionText(
            text: "Time to reach the goal: $time",
            size: DescriptionText.P2,
          ),

          const SizedBox(height: 8),

          // Maximum value achieved in the replication of the expression
          DescriptionText(
            text: "Max value for expression: $maxValueForExpression",
            size: DescriptionText.P2,
          ),

          const SizedBox(height: 12),

          const Divider(color: PaletteColor.darkBlue, thickness: 1), // Dividing line
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PrimaryButton(
                text: "Restart",
                height: PrimaryButton.PauseButton,
                onPressed: () {
                  Navigator.of(context).pop(); // Closing alert dialog
                  handleRestart();
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SecondaryButton(
                text: "Quit",
                fontSize: SecondaryButton.fontSizeAlertDialog,
                onPressed: () {
                  // Double pop to return in training page
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}