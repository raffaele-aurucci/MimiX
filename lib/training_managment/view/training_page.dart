import 'package:flutter/material.dart';
import 'package:mimix_app/training_managment/view/training_overview_page.dart';
import 'package:mimix_app/training_managment/view/training_session_page.dart';

import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/cards/homepage_card.dart';
import '../../utils/view/widgets/cards/training_card.dart';
import '../../utils/view/widgets/texts/header_text.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key, required this.title});

  final String title;

  @override
  _TrainingPage createState() => _TrainingPage();
}

class _TrainingPage extends State<TrainingPage> {
  bool _isTextVisible = false; // To manage the visibility of the text in AppBar()

  // List names of games
  List<String> nameTrainingList = [
    "Mouth Smile",
    "Mouth Open",
    "Mouth Pucker",
    "Mouth Lower",
    "Brow Down",
    "Brow Up",
    "Premium Training",
    "Premium Training",
  ];

  // List emoji
  List<String> emojiImagePath = [
    'assets/images/emoticons/mouth_smile.png',
    'assets/images/emoticons/mouth_open.png',
    'assets/images/emoticons/mouth_pucker.png',
    'assets/images/emoticons/mouth_lower.png',
    'assets/images/emoticons/brow_up.png',
    'assets/images/emoticons/brow_down.png',
    'assets/images/emoticons/lock.png',
    'assets/images/emoticons/lock.png',
  ];

  List<String> nameTrainingDescriptionList = [
    "Learn to form a natural smile",
    "Practice opening your mouth naturally",
    "Master puckering your lips for focused gestures",
    "Practice lowering your bottom lip",
    "Enhance your skill in raising your eyebrows",
    "Improve your ability to lower your eyebrows",
    "Upgrade now to access this session!",
    "Upgrade now to access this session!",
  ];

  List<String> nameTrainingOverviewDescriptionList = [
    "Smile naturally to engage and strengthen the zygomatic muscles for better expressions.",
    "Open your mouth naturally to train and relax the orbicularis oris and other muscles.",
    "Pucker your lips tightly to improve the strength and focus of the orbicularis oris.",
    "Lower your bottom lip to refine control of the depressor labia and related muscles.",
    "Raise your eyebrows to enhance the mobility and precision of the frontalis muscles.",
    "Lower your eyebrows to effectively strengthen and control the frontalis muscles.",
    "",
    "",
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
            text: 'Training',
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
                  title: 'Training',
                  image: const AssetImage('assets/images/icons/training_icon.png'),
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
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                  shrinkWrap: true, // Let GridView size itself within the scrollable column
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two cards per row
                    crossAxisSpacing: 10.0, // Horizontal spacing
                    mainAxisSpacing: 10.0, // Vertical spacing
                  ),
                  itemCount: 8, // Number of TrainCards
                  itemBuilder: (context, index) {
                    if(index >= 6) {
                      return TrainingCard(
                        title: nameTrainingList[index],
                        description: nameTrainingDescriptionList[index],
                        onTap: () => {},
                        image: emojiImagePath[index]
                      );
                    }
                    else {
                      return TrainingCard(
                        title: nameTrainingList[index],
                        description: nameTrainingDescriptionList[index],
                        onTap: () =>
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                // Passes the expression to be trained to the training session page
                                  builder: (context) =>
                                      TrainingOverviewPage(
                                        expression: nameTrainingList[index],
                                        description: nameTrainingOverviewDescriptionList[index],
                                      )
                              )
                          )
                        },
                        image: emojiImagePath[index]
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
