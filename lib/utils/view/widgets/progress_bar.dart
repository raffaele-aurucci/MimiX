import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // % progress of bar (double type)

  const ProgressBar({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7, // To edit
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F4),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(16.0),
          value: progress,
          backgroundColor: const Color(0xFFF0F2F4),
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xFF97CADB), // Colore di default della barra
          ),
        ),
      ),
    );
  }
}

//  CREATION EXAMPLE
//  ProgressBar(progress: 0.9),

// This snippet of code creates a progress bar with the progression of the bar relative to the value provided in input.