import 'package:mimix_app/reward_managment/view/reward_page.dart';
import 'package:mimix_app/task_managment/view/task_page.dart';
import 'package:mimix_app/user_management/beans/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/widgets/cards/homepage_card.dart';
import 'package:mimix_app/utils/view/widgets/user_level.dart';
import 'package:provider/provider.dart';

import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 0, left: 20, right: 20),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    HeaderText(text: '👋🏻 Hi ${context.watch<UserProvider>().user!.username}!', size: HeaderText.H4),
                    ProfileImageWithLevel(
                      experienceLevel: context.watch<UserProvider>().user!.level,
                      experienceProgress: context.watch<UserProvider>().user!.levelProgress + 0.2,
                      profileImage: const AssetImage('assets/images/user.png'),
                    )
                  ],),
                  const SizedBox(height: 40),
                  HomePageCard(
                      title: "Minigames",
                      image: const AssetImage('assets/images/minigames_icon.png'),
                      onTap: () => {
                      Navigator.pushNamed(context, '/minigames_page')
                      }),
                  const SizedBox(height: 10),
                  HomePageCard(
                      title: "Training",
                      image: const AssetImage('assets/images/training_icon.png'),
                      onTap: () => {
                        Navigator.pushNamed(context, '/training_page')
                      }),
                  const SizedBox(height: 10),
                  HomePageCard(
                      title: "Tasks",
                      image: const AssetImage('assets/images/tasks_icon.png'),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TaskPage(title: 'Tasks'),
                          ),
                        )
                      }),
                  const SizedBox(height: 10),
                  HomePageCard(
                      title: "Rewards",
                      image: const AssetImage('assets/images/rewards/rewards_icon.png'),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RewardPage(title: 'Rewards'),
                          ),
                        )
                      })
                ],
              )
            )
        )
      ),
    );
  }
}