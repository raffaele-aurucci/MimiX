import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';
import 'buttons/primary_button.dart';
import 'buttons/secondary_button.dart';

class GameOverMenu extends StatelessWidget {

  final String gameName;
  final String quitNavigate;
  final Function() handleRestart;

  const GameOverMenu({
    super.key,
    required this.gameName,
    required this.quitNavigate,
    required this.handleRestart,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderText(
                  text: gameName,
                  size: HeaderText.H4
              ),
              SizedBox(height: 10),
              PrimaryButton(
                text: 'Restart',
                onPressed: () {
                  Navigator.of(context).pop();
                  handleRestart();
                },
                height: 32, // Altezza ridotta
              ),
              SecondaryButton(
                  text: 'Quit',
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName(quitNavigate));
                  },
              ),
            ],
          ),
        ),
      )
    );
  }
}

//  CREATION EXAMPLE
//  CardTitleText(text: 'title', size: CardTitleText.H6),

// This snippet of code creates a card title text. You can choose between two types of text: H5 and H6.
