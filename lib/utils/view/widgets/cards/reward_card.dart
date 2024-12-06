import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';
import 'package:mimix_app/utils/view/widgets/texts/card_title_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';
import 'package:mimix_app/utils/view/widgets/progress_bar.dart';

class RewardCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final AssetImage image;

  const RewardCard({
    Key? key,
    required this.title,
    required this.description,
    required this.progress,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Card(
        color: PaletteColor.whiteColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardTitleText(text: title, size: CardTitleText.H5),
                        SizedBox(height: 8),
                        DescriptionText(text: description, size: DescriptionText.P1),
                      ],
                    ),
                  ),
                  Container(
                    width: 125,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: image,
                      ),
                    ),
                  ),
                ],
              ),
              ProgressBar(
                  progress: progress,
                  height: ProgressBar.bigCard,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  CREATION EXAMPLE
//  RewardCard(
//               title: 'Reward',
//               description: 'Description reward',
//               progress: 0.5,
//               image: AssetImage('assets/images/train.png')
//             )

// This snippet of code creates a reward card with a title, a description, an imaage and a progress bar in the bottom.
// For the progression of bar, you simply need to provide a value from 0 to 1 (double type).
// For the image, you can provide at the class only the image from the assets folder.
