import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: PaletteColor.darkBlue,
        foregroundColor: PaletteColor.whiteColor,
        minimumSize: const Size.fromHeight(56),
        textStyle: const TextStyle(fontFamily: 'Raleway', fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

// CREATION EXAMPLE
//  PrimaryButton(
//               text: 'Button name',
//               onPressed: () => debugPrint('Primary button pressed'),
//             )

// This snippet of code creates a primary button.
// When the button is pressed, a debug message is printed.