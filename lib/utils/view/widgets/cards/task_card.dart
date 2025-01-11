import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';
import 'package:mimix_app/utils/view/widgets/texts/card_title_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';
import 'package:mimix_app/utils/view/widgets/progress_bar.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress; // Progress value

  const TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // To edit
      height: 150, // To edit
      child: Card(
        color: PaletteColor.whiteColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitleText(text: title, size: CardTitleText.H6,),
              SizedBox(height: 8),
              DescriptionText(text: description, size: DescriptionText.P2),
              SizedBox(height: 8),
              // TODO: keep the progress bar in the footer of the card
              ProgressBar(
                progress: progress,
                height: ProgressBar.heightSmallCard,
                orientation: ProgressBar.horizontal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  CREATION EXAMPLE
//  TaskCard(
//            title: 'Task title',
//            description: 'Task description',
//            progress: 0.1,
//           )

// This snippet of code creates a task card with a title, a description and a progress bar in the bottom.
// For the progression of bar, you simply need to provide a value from 0 to 1 (double type).