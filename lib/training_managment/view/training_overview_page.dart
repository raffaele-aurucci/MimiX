import 'package:flutter/material.dart';
import 'package:mimix_app/training_managment/view/training_session_page.dart';
import 'package:provider/provider.dart';

import '../../user_management/beans/user_provider.dart';
import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/buttons/primary_button.dart';
import '../../utils/view/widgets/texts/description_text.dart';
import '../../utils/view/widgets/texts/header_text.dart';

class TrainingOverviewPage extends StatefulWidget {
  const TrainingOverviewPage({super.key, required this.expression, required this.description});

  final String expression;
  final String description;

  @override
  State<TrainingOverviewPage> createState() => _TrainingOverviewPage();
}

class _TrainingOverviewPage extends State<TrainingOverviewPage> {

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
        appBar: AppBar(
          leading: IconButtonWidget(
              icon: Icons.arrow_back,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SafeArea(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            margin: const EdgeInsets.only(top: 0, bottom: 40, left: 20, right: 20),
            child: Column(
                children: [
                  HeaderText(text: widget.expression, size: HeaderText.H3),

                  SizedBox(height: 20),

                  Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        height: screenHeight * 0.45,
                        child: const Image(image: AssetImage('assets/images/face_mesh.png')),
                  ),

                  const SizedBox(height: 10),

                  DescriptionText(
                      text: widget.description,
                      size: DescriptionText.P1,
                      alignment: DescriptionText.Center,
                  ),

                  const Spacer(),

                  PrimaryButton(
                          text: "Let's go!",
                          onPressed: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    TrainingSessionPage(
                                        expression: widget.expression,
                                        userLevel: context.watch<UserProvider>().user!.level,
                                    )))
                          }
                      )
                ]
            ),
          ),
        )
    );
  }
}