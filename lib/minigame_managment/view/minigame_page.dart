import 'package:flutter/material.dart';
import 'package:mimix_app/minigame_managment/dino_run/face_run_page.dart';
import 'package:mimix_app/utils/view/app_palette.dart';
import 'package:mimix_app/utils/view/widgets/cards/homepage_card.dart';
import 'package:mimix_app/utils/view/widgets/cards/minigame_card.dart';
import 'package:mimix_app/utils/view/widgets/buttons/icon_button.dart';
import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';

import '../breakout/face_breakout_page.dart';
import '../face_ski/face_ski_page.dart';

class MinigamePage extends StatefulWidget {
  const MinigamePage({super.key, required this.title});

  final String title;

  @override
  _MinigamePage createState() => _MinigamePage();
}

class _MinigamePage extends State<MinigamePage> {
  bool _isTextVisible = false; // To manage the visibility of the text in AppBar()

  // List names of games
  List<String> nameGameList = [
    "Face Breakout",
    "Face Run",
    "Face Ski",
    "Face Kick",
    "Stay Tuned",
    "Stay Tuned",
    "Stay Tuned",
    "Stay Tuned",
    "Stay Tuned",
    "Stay Tuned",
    "Stay Tuned",
    "Stay Tuned"
  ];

  // List image of games
  List<AssetImage> imageGameList = [
    const AssetImage('assets/images/breakout.png'),
    const AssetImage('assets/images/dino_run.jpg'),
    const AssetImage('assets/images/ski_master_card_image.png'),
    const AssetImage('assets/images/question_mark.jpg'),
    const AssetImage('assets/images/question_mark.jpg'),
    const AssetImage('assets/images/question_mark.jpg'),
    const AssetImage('assets/images/question_mark.jpg'),
    const AssetImage('assets/images/question_mark.jpg'),
    const AssetImage('assets/images/question_mark.jpg'),
    const AssetImage('assets/images/question_mark.jpg'),
    const AssetImage('assets/images/question_mark.jpg'),
    const AssetImage('assets/images/question_mark.jpg'),
  ];

  // To change the visibility of the text when you scroll
  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics.pixels >= 65 && !_isTextVisible) {
      setState(() {
        _isTextVisible = true;
      });
    } else if (notification.metrics.pixels < 65 && _isTextVisible) {
      setState(() {
        _isTextVisible = false;
      });
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButtonWidget(
          icon: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Visibility(
          visible: _isTextVisible,
          child: const HeaderText(
            text: 'Minigames',
            size: HeaderText.H4,
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScroll, // Listen to the scroll events
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HomePageCard at the top
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: HomePageCard(
                  title: 'Minigames',
                  image: const AssetImage('assets/images/minigames_icon.png'),
                  onTap: () => print('Home page card'),
                ),
              ),
              const SizedBox(height: 8.0),
              // Grid of Minigames
              Container(
                decoration: const BoxDecoration(
                  color: PaletteColor.powderBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(20.0), // Padding for the grid
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                  shrinkWrap: true, // Let GridView size itself within the scrollable column
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two cards per row
                    crossAxisSpacing: 10.0, // Horizontal spacing
                    mainAxisSpacing: 10.0, // Vertical spacing
                  ),
                  itemCount: 12, // Number of TrainCards
                  itemBuilder: (context, index) {
                    if(index == 0){
                      return MinigameCard(
                        title: nameGameList[index],
                        image: imageGameList[index],
                        onTap: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const FaceBreakoutPage())
                          )},
                      );
                    }
                    else if (index == 1){
                      return MinigameCard(
                        title: nameGameList[index],
                        image: imageGameList[index],
                        onTap: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const FaceRunPage())
                          )},
                      );
                    }
                    else if (index == 2){
                      return MinigameCard(
                        title: nameGameList[index],
                        image: imageGameList[index],
                        onTap: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const FaceSkiPage())
                          )},
                      );
                    }
                    else {
                      return MinigameCard(
                        title: nameGameList[index],
                        image: imageGameList[index],
                        onTap: () => {},
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
