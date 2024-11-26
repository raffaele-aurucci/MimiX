import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SecondaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: PaletteColor.backgroundColor,
        foregroundColor: PaletteColor.darkBlue,
        minimumSize: Size(150, 40), // Min size of button (w, h)
        maximumSize: Size(200, 60), // Max size of button (w, h)
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        textStyle: const TextStyle(fontFamily: 'Raleway', fontSize: 14, fontWeight: FontWeight.w500),
        side: const BorderSide(
          color: PaletteColor.darkBlue,
        ),
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
//  SecondaryButton(
//               text: 'Button name',
//               onPressed: () => debugPrint('Primary button pressed'),
//             )

// This snippet of code creates a secondary button.
// When the button is pressed, a debug message is printed.
