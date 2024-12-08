import 'package:mimix_app/minigame_managment/view/minigame_page.dart';
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
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                      profileImage: const AssetImage('assets/images/welcome.png'),
                    )
                  ],),
                  const SizedBox(height: 20),
                  HomePageCard(
                      title: "Minigames",
                      image: AssetImage('assets/images/image.png'),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MinigamePage(title: 'Minigames'),
                          ),
                        )
                      }),
                  HomePageCard(
                      title: "Training",
                      image: AssetImage('assets/images/image.png'),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainingPage(title: 'Training'),
                          ),
                        )
                      }),
                  HomePageCard(
                      title: "Tasks",
                      image: AssetImage('assets/images/image.png'),
                      onTap: () => {}),
                  HomePageCard(
                      title: "Rewards",
                      image: AssetImage('assets/images/image.png'),
                      onTap: () => {})
                ],
              )
            )
        )
      ),
      bottomNavigationBar: const FooterMenu(selectedIndex: 0),
    );
  }
}