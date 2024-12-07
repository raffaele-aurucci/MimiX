import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class DescriptionText extends StatelessWidget {

  static const double P1 = 16; // For mini-games description
  static const double P2 = 14; // For trains e tasks description
  static const TextAlign Center = TextAlign.center; // For center alignment

  final String text;
  final double size;
  final TextAlign? alignment;

  const DescriptionText({super.key, required this.text, required this.size, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
        color: PaletteColor.darkBlue,
      ),
      textAlign: alignment ?? TextAlign.left,
    );
  }
}

//  CREATION EXAMPLE
//  DescriptionText(text: 'title', size: CardTitleText.P1),

// This snippet of code creates a description text. You can choose between two types of text: P1 and P2.
// You can also choose whether you want an alignment of text.