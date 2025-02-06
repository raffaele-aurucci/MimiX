import 'package:flutter/material.dart';
import 'package:mimix_app/user_management/view/registration_page.dart';

import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/texts/description_text.dart';
import '../../utils/view/widgets/texts/header_text.dart';

class TutorialPage extends StatelessWidget {

  static final int NUMBER_OF_POINT = 3; // Number of point

  final String title;
  final String description;
  final String imagePath;
  final String buttonText;
  final int indexPage;

  const TutorialPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.buttonText,
    required this.indexPage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
        children: [

          const SizedBox(height: 30),

          Container(
            child: Image.asset(imagePath),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              NUMBER_OF_POINT,
                  (index) => Container(
                margin: const EdgeInsets.all(4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: indexPage == index ? PaletteColor.darkBlue : PaletteColor.progressBarBackground,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          HeaderText(
              text: title,
              size: HeaderText.H3
          ),

          const SizedBox(height: 10),

          DescriptionText(
            text: description,
            size: DescriptionText.P1,
            alignment: DescriptionText.Center,
          ),

          const Spacer(),

          GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegistrationPage()))
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: PaletteColor.darkBlue,
                  decoration: TextDecoration.underline,
                ),
              )

          )
        ]
    );
  }
}
