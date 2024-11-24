import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const IconButtonWidget({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 32.0,
      color: const Color(0xFF003659),
      onPressed: onPressed,
    );
  }
}

// CREATION EXAMPLE
// IconButtonWidget(icon: Icons.pause,
//                  onPressed: () => debugPrint('Icon button pressed'),
//                 )

// This snippet of code creates an icon that shows the pause button.
// When the button is pressed, a debug message is printed.
// You can choose between different types of icon. In this case, the icons used are those provided by Flutter.