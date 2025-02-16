import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mimix_app/application_management/view/tutorial_pages.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final pages = getTutorialPages();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              margin: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      children: pages,
                    ),
                  ),
                ],
              ),
            )
        )
      )
    );
  }
}
