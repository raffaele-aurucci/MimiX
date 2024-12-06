import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';
import 'package:mimix_app/utils/view/widgets/texts/card_title_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';


class TrainCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap; // Add the function to start the training session

  const TrainCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // To edit
      height: 150, // To edit
      child: GestureDetector(
        onTap: onTap, // Add the function
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
                CardTitleText(text: title, size: CardTitleText.H6),
                SizedBox(height: 8),
                DescriptionText(text: description, size: DescriptionText.P2,),
              ],
            ),
          ),
        ),
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
