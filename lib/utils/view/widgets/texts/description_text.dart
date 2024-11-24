import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {

  static const double P1 = 16; // For mini-games description
  static const double P2 = 14; // For trains e tasks description

  final String text;
  final double size;

  const DescriptionText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF003659),
      ),
    );
  }
}

//  CREATION EXAMPLE
//  DescriptionText(text: 'title', size: CardTitleText.P1),

// This snippet of code creates a description text. You can choose between two types of text: P1 and P2.
