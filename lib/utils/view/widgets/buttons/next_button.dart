import 'package:flutter/material.dart';

import '../../app_palette.dart';

class NextButton extends StatelessWidget {

  final String text;
  final VoidCallback? onPressed;
  final double? height;

  const NextButton({super.key, required this.text, required this.onPressed, this.height});


  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: PaletteColor.darkBlue,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}