import 'dart:math';
import 'package:flutter/material.dart';

import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/cards/homepage_card.dart';
import '../../utils/view/widgets/cards/task_card.dart';
import '../../utils/view/widgets/texts/header_text.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.title});

  final String title;

  @override
  _TaskPage createState() => _TaskPage();
}

class _TaskPage extends State<TaskPage> {
  bool _isTextVisible = false; // To manage the visibility of the text in AppBar()

  Random random = Random();

  // List names of games
  List<String> nameTaskList = [
    "Brow Down",
    "Brow Up",
    "Mouth Open",
    "Mouth Smile",
    "Mouth Pucker",
    "Mouth Lower"
  ];

  List<String> nameTaskDescriptionList = [
    "Improve your ability to lower your eyebrows",
    "Enhance your skill in raising your eyebrows",
    "Practice opening your mouth naturally mouth",
    "Learn to form a natural smile form natural",
    "Master puckering your lips for focused gestures",
    "Practice lowering your bottom lip focused"
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
            text: 'Task',
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
                  title: 'Tasks',
                  image: AssetImage('assets/images/tasks_icon.png'),
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
                  itemCount: 6, // Number of TrainCards
                  itemBuilder: (context, index) {
                    return TaskCard(
                      title: nameTaskList[index],
                      description: nameTaskDescriptionList[index],
                      progress: random.nextDouble(),
                    );
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
