import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mimix_app/minigame_managment/breakout/face_breakout_game_page.dart';
import 'package:mimix_app/minigame_managment/breakout/src/breakout.dart';
import 'package:mimix_app/minigame_managment/breakout/src/config.dart';
import 'package:mimix_app/utils/view/widgets/buttons/primary_button.dart';

import 'package:mimix_app/utils/view/app_palette.dart';

import '../../utils/view/widgets/buttons/icon_button.dart';
import '../../utils/view/widgets/texts/description_text.dart';
import '../../utils/view/widgets/texts/header_text.dart';
import '../../utils/view/widgets/alert_dialog.dart';

class FaceBreakoutPage extends StatefulWidget {
  const FaceBreakoutPage({super.key});

  @override
  State<FaceBreakoutPage> createState() => _FaceBreakoutOverviewPageState();
}

class _FaceBreakoutOverviewPageState extends State<FaceBreakoutPage> {

  // static game for adding scene
  late final Breakout game;

  @override
  void initState() {
    super.initState();
    game = Breakout(handleWon: () => {}, handleGameOver: () => {});
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
                  HeaderText(text: 'Face Breakout', size: HeaderText.H3),
                  SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              HeaderText(text: '😊', size: HeaderText.H4),
                              HeaderText(text: ' Left', size: 20.0),
                            ],
                          ),
                          Row(
                            children: [
                              HeaderText(text: '😚', size: HeaderText.H4),
                              HeaderText(text: ' Right', size: 20.0),
                            ],
                          ),
                        ],
                      ),
                      // Right side
                      Column(
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
                      child: GameWidget.controlled(
                        gameFactory: () => game,
                  ),
                  )),


                  const DescriptionText(
                    text: 'Face Breakout is a classic game where players use a paddle, controlled by facial expressions, to break bricks.',
                    size: DescriptionText.P1,
                    alignment: DescriptionText.Center,
                  ),

                  const SizedBox(height: 15),

                  PrimaryButton(
                      text: 'Play',
                      onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const FaceBreakoutGamePage()))
                      }
                  )
                ]
            ),
          ),
        )
    );
  }
}