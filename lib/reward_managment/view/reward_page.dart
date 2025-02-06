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
    "King of Smile",
    "Master of Focus",
    "Surprise Champion",
    "Jaw Dropper",
    "Kiss Master",
    "Jawbreaker Pro",
    "Premium Reward",
    "Premium Reward",
  ];

  List<double> progressRewardList = [0.4, 0.25, 1, 0.3, 0.2, 0.4, 0, 0];

  // List path image
  List<String> ImagePath = [
    'assets/images/reward/reward_mouth_smile.png',
    'assets/images/reward/reward_brow_down.png',
    'assets/images/reward/reward_brow_up.png',
    'assets/images/reward/reward_mouth_open.png',
    'assets/images/reward/reward_mouth_pucker.png',
    'assets/images/reward/reward_mouth_lower.png',
    'assets/images/emoticons/lock.png',
    'assets/images/emoticons/lock.png',
  ];

  List<String> nameRewardDescriptionList = [
    "Achieve 100 mouth smiles and become the true maestro of smile!",
    "Lower your eyebrows 35 times to unlock your intense focus skills!",
    "Raise your eyebrows 50 times and master the art of surprise!",
    "Open your mouth 110 times and become the ultimate jaw-dropper!",
    "Pucker your lips 70 times and perfect your kiss technique!",
    "Lower your mouth 25 times and perfect your jaw control!",
    "Upgrade now to unlock this reward!",
    "Upgrade now to unlock this reward!"
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
                      image: const AssetImage('assets/images/reward/rewards_icon.png'),
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
                        ...List.generate(nameRewardList.length, (index) {
                          return Column(
                            children: [
                              RewardCard(
                                title: nameRewardList[index],
                                description: nameRewardDescriptionList[index],
                                progress: progressRewardList[index],
                                image: AssetImage(ImagePath[index]),
                                complete: progressRewardList[index] == 1? true : false,
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        )
    );
  }
}
