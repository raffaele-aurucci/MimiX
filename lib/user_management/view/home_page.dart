import 'package:mimix_app/minigame_managment/view/minigame_page.dart';
import 'package:mimix_app/reward_managment/view/reward_page.dart';
import 'package:mimix_app/task_managment/view/task_page.dart';
import 'package:mimix_app/training_managment/view/training_page.dart';
import 'package:mimix_app/user_management/beans/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/widgets/cards/homepage_card.dart';
import 'package:mimix_app/utils/view/widgets/footer_menu.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                  const SizedBox(height: 20),
                  HomePageCard(
                      title: "Minigames",
                      image: const AssetImage('assets/images/minigames_icon.png'),
                      onTap: () => {
                      Navigator.pushNamed(context, '/minigames_page')
                      }),
                  HomePageCard(
                      title: "Training",
                      image: const AssetImage('assets/images/training_icon.png'),
                      onTap: () => {
                        Navigator.pushNamed(context, '/training_page')
                      }),
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
                  HomePageCard(
                      title: "Rewards",
                      image: const AssetImage('assets/images/rewards_icon.png'),
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
      bottomNavigationBar: const FooterMenu(selectedIndex: 0),
    );
  }
}