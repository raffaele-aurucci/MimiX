import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';
import 'package:mimix_app/utils/view/widgets/texts/card_title_text.dart';

class HomePageCard extends StatelessWidget {
  final String title;
  final AssetImage image;
  final VoidCallback onTap;

  const HomePageCard({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      // GestureDetector is a fundamental tool for making widgets interactive and responding to gestures without
      // using predefined widgets such as buttons.
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
          color: PaletteColor.powderBlue,
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
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between two columns
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardTitleText(text: title, size: CardTitleText.H5),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: image,
                    ),
                  ),
                ),
              ],
            ),
        ),
      );
  }
}

//  CREATION EXAMPLE
//  HomePageCard(
//               title: 'Card title',
//               image: Image.asset('assets/images/image.png'),
//               onPressed: () => print('Home Card Tapped!'),
//             ),

// This snippet of code creates a home-page card with a text in the left side and an image in the right side.
// When the card is pressed, a message is printed.
// In this case, you can provide at the class different type of image source (also by network) because
// the variable that manages the image is Widget type.