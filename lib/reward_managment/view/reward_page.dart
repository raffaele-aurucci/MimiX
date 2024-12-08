import 'package:flutter/material.dart';

import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/cards/homepage_card.dart';
import '../../utils/view/widgets/cards/reward_card.dart';
import '../../utils/view/widgets/texts/header_text.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key, required this.title});

  final String title;

  @override
  _RewardPage createState() => _RewardPage();
}

class _RewardPage extends State<RewardPage> {
  bool _isTextVisible = false; // To manage the visibility of the text in AppBar()

  // List names of games
  List<String> nameRewardList = [
    "Level 5",
    "Level 10",
    "Level 15",
    "Level 20",
    "Level 25",
    "Level 30",
    "Level 35",
    "Level 40",
  ];

  List<String> nameRewardDescriptionList = [
    "Reach 5 level!",
    "Reach 10 level!",
    "Reach 15 level!",
    "Reach 20 level!",
    "Reach 25 level!",
    "Reach 30 level!",
    "Reach 35 level!",
    "Reach 40 level!",
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
            text: 'Rewards',
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
                  title: 'Rewards',
                  image: AssetImage('assets/images/rewards_icon.png'),
                  onTap: () => print('Home page card'),
                ),
              ),
              const SizedBox(height: 8.0),
              // Grid of TrainCards
              Container(
                decoration: const BoxDecoration(
                  color: PaletteColor.powderBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(20.0), // Padding for the grid
                child: Column(
                  children: [
                    // TODO: find a way to build automatically the Reaward Card in the list
                    RewardCard(
                      title: nameRewardList[0],
                      description: nameRewardDescriptionList[0],
                      progress: 0.1,
                      image: AssetImage('assets/images/rewards_icon.png'),
                    ),
                    RewardCard(
                      title: nameRewardList[1],
                      description: nameRewardDescriptionList[1],
                      progress: 0.05,
                      image: AssetImage('assets/images/rewards_icon.png'),
                    ),
                    RewardCard(
                      title: nameRewardList[2],
                      description: nameRewardDescriptionList[2],
                      progress: 0.01,
                      image: AssetImage('assets/images/rewards_icon.png'),
                    ),
                    RewardCard(
                      title: nameRewardList[3],
                      description: nameRewardDescriptionList[3],
                      progress: 0.005,
                      image: AssetImage('assets/images/rewards_icon.png'),
                    ),
                    RewardCard(
                      title: nameRewardList[4],
                      description: nameRewardDescriptionList[4],
                      progress: 0.001,
                      image: AssetImage('assets/images/rewards_icon.png'),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
