import 'package:flutter/material.dart';

class CardTitleText extends StatelessWidget {

  static const double H5 = 20; // For home-page cards title
  static const double H6 = 16; // For task, train and mini-game cards title

  final String text;
  final double size;

  const CardTitleText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF003659),
      ),
    );
  }
}

//  CREATION EXAMPLE
//  CardTitleText(text: 'title', size: CardTitleText.H6),

// This snippet of code creates a card title text. You can choose between two types of text: H5 and H6.
