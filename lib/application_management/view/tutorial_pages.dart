import 'package:flutter/material.dart';
import 'tutorial_page.dart';

List<Widget> getTutorialPages() {
  return [
    const TutorialPage(
      title: "Play with your face",
      description: "With Mimix, you can have fun exploring your facial muscles while training them. Discover interactive exercises and engaging challenges to improve control and tone your face!",
      imagePath: "assets/images/tutorial_1.png",
      buttonText: "Skip tour",
      indexPage: 0,
    ),
    const TutorialPage(
      title: "Training",
      description: "Train your facial muscles with targeted and engaging exercises. Mimix helps you improve control and strength while having fun!",
      imagePath: "assets/images/tutorial_2.png",
      buttonText: "Skip tour",
      indexPage: 1,
    ),
    const TutorialPage(
      title: "Improve",
      description: "Enhance your facial tone and mobility with personalized sessions. Track your progress and unlock the full potential of your facial muscles!",
      imagePath: "assets/images/tutorial_3.png",
      buttonText: "Close",
      indexPage: 2,
    ),
  ];
}
