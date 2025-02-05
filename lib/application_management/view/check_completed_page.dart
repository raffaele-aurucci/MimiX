import 'package:flutter/material.dart';
import 'package:mimix_app/training_managment/view/training_session_page.dart';
import 'package:mimix_app/user_management/view/menu_page.dart';
import 'package:provider/provider.dart';

import '../../user_management/beans/user_provider.dart';
import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/buttons/primary_button.dart';
import '../../utils/view/widgets/texts/description_text.dart';
import '../../utils/view/widgets/texts/header_text.dart';

class CheckCompletedPage extends StatefulWidget {
  const CheckCompletedPage({super.key});

  @override
  State<CheckCompletedPage> createState() => _CheckCompletedStatePage();
}

class _CheckCompletedStatePage extends State<CheckCompletedPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            margin: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
            child: Column(
                children: [

                  const SizedBox(height: 30),

                  Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Image.asset('assets/images/check_completed.png',),
                  ),

                  const SizedBox(height: 20),

                  const HeaderText(text: 'Check completed', size: HeaderText.H3),

                  const SizedBox(height: 10),

                  const DescriptionText(
                      text: "Awesome! Facial expression recognition is complete, and you're ready to jump into the game! Now you can use your expressions to interact and immerse yourself in a unique experience.",
                      size: DescriptionText.P1,
                      alignment: DescriptionText.Center,
                  ),

                  const Spacer(),

                  PrimaryButton(
                          text: "Let's get started!",
                          onPressed: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const MenuPage()))
                          }
                      )
                ]
            ),
          ),
        )
    );
  }
}