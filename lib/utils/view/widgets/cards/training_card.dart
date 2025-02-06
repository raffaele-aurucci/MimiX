import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';
import 'package:mimix_app/utils/view/widgets/texts/card_title_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';


class TrainingCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final VoidCallback onTap; // Add the function to start the training session

  const TrainingCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
              width: 150, // To edit
              height: 150, // To edit
              // Add the function
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: PaletteColor.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(color: PaletteColor.borderCard, width: 1)
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardTitleText(text: title, size: CardTitleText.H6),
                    const SizedBox(height: 8),
                    DescriptionText(text: description, size: DescriptionText.P2,),
                  ],
                ),
              )
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Image.asset(
              image,
              width: 25,
              height: 25,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      );
  }
}

//  CREATION EXAMPLE
//  TrainCard(
//            title: 'Train title',
//            description: 'Training session description',
//            onTap: FUNCTION,
//           ),

// This snippet of code creates a train card with a title and a description.
// You need to add a function to start the training session selected.
