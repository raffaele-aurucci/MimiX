import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';
import 'package:mimix_app/utils/view/widgets/texts/card_title_text.dart';

class MinigameCard extends StatelessWidget {
  final String title;
  final AssetImage image;
  // final VoidCallback onTap; // Add the function to start the mini-game

  const MinigameCard({
    Key? key,
    required this.title,
    required this.image,
    // this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap, // To link the function to card
      child: Container(
        height: 150, // To edit
        width: 150, // To edit
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover, // To put the image in background
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: PaletteColor.whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                width: double.infinity,
                child: CardTitleText(text: title, size: CardTitleText.H6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//  CREATION EXAMPLE
//  MinigameCard(title: 'Minigame name',
//               image: AssetImage('assets/images/train.png'),
//               onTap: FUNCTION
//              ),

// This snippet of code creates a mini-game card with a text at the bottom and an image in the background.
// When you define a function and the card is pressed, the selected mini-game starts.
// In this case, you can provide at the class different only the image from the assets folder.
