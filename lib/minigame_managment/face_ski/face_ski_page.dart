import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/game.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/globals.dart';
import 'package:mimix_app/utils/view/widgets/buttons/primary_button.dart';

import 'package:mimix_app/utils/view/app_palette.dart';

import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/texts/description_text.dart';
import '../../utils/view/widgets/texts/header_text.dart';
import 'face_ski_game_page.dart';

class FaceSkiPage extends StatefulWidget {
  const FaceSkiPage({super.key});
  @override
  State<FaceSkiPage> createState() => _FaceSkiOverviewPageState();
}

class _FaceSkiOverviewPageState extends State<FaceSkiPage> {

  // static game for adding scene
  late final FaceSkiGame game = FaceSkiGame();

  @override
  void initState() {
    super.initState();
    GlobalState.isPreviewPage = true;
    game.startGameBlocked();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            margin: const EdgeInsets.only(top: 0, bottom: 40, left: 20, right: 20),
            child: Column(
                children: [
                  const HeaderText(text: 'Face Ski', size: HeaderText.H3),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/emoticons/mouth_open.png', width: 30, height: 30),
                              const HeaderText(text: ' Left', size: 20.0),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Image.asset('assets/images/emoticons/mouth_smile.png', width: 30, height: 30),
                              const HeaderText(text: ' Right', size: 20.0),
                            ],
                          )
                        ],
                      ),
                      // Right side
                      const Column(
                        children: [
                          HeaderText(text: '00000', size: HeaderText.H4),
                          DescriptionText(text: 'HI 00000', size: DescriptionText.P2)
                        ],
                      )
                    ],
                  ),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: PaletteColor.darkBlue, width: 2)
                      ),
                      child: GameWidget(
                        game: game,
                      )
                  )),


                  const DescriptionText(
                    text: 'Face Ski lets players control a skier with facial expressions, racing to the finish, collecting rewards, and dodging obstacles.',
                    size: DescriptionText.P1,
                    alignment: DescriptionText.Center,
                  ),

                  const SizedBox(height: 15),

                  PrimaryButton(
                      text: 'Play',
                      onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const FaceSkiGamePage())),
                            GlobalState.isPreviewPage = false
                      }
                  )
                ]
            ),
          ),
        )
    );
  }
}