import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user_management/beans/user_provider.dart';
import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/cards/general_task_card.dart';
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
    "Mouth Smile",
    "Mouth Open",
    "Mouth Pucker",
    "Mouth Lower",
    "Brow Up",
    "Brow Down",
    "Premium Task",
    "Premium Task"
  ];

  List<String> nameTaskDescriptionList = [
    "Learn to form a natural smile form natural",
    "Practice opening your mouth naturally mouth",
    "Master puckering your lips",
    "Practice lowering your bottom lip",
    "Enhance your skill in raising your eyebrows",
    "Improve your ability to lower your eyebrows",
    "Upgrade now to complete this task!",
    "Upgrade now to complete this task!"
  ];

  List<double> progressValue = [1, 0.4, 0.3, 0.2, 0.8, 0.6, 0, 0];

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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // General card at the top of list of tasks
                    //TODO: make the task dynamic: add the last three best tasks based on their progress.
                    GeneralTaskCard(
                        experienceLevel: context.watch<UserProvider>().user!.level,
                        experienceProgress: context.watch<UserProvider>().user!.levelProgress + 0.2,
                        firstProgress: progressValue[0],
                        firstTaskName: nameTaskList[0],
                        secondProgress: progressValue[4],
                        secondTaskName: nameTaskList[4],
                        thirdProgress: progressValue[5],
                        thirdTaskName: nameTaskList[5],
                    ),
                    const SizedBox(height: 10),
                    // GridView of tasks
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                      shrinkWrap: true, // Let GridView size itself within the scrollable column
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two cards per row
                        crossAxisSpacing: 10.0, // Horizontal spacing
                        mainAxisSpacing: 10.0, // Vertical spacing
                      ),
                      itemCount: 8, // Number of TrainCards
                      itemBuilder: (context, index) {
                        return TaskCard(
                          title: nameTaskList[index],
                          description: nameTaskDescriptionList[index],
                          progress: progressValue[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
