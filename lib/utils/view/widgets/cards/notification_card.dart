import 'package:flutter/material.dart';

import '../../app_palette.dart';
import '../texts/card_title_text.dart';
import '../texts/description_text.dart';


class NotificationCard extends StatelessWidget {
  final bool isNew;
  final String title;
  final String content;

  const NotificationCard({
    required this.isNew,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: PaletteColor.whiteColor,
          borderRadius: BorderRadius.circular(12.0),
          // border: Border.all(color: PaletteColor.borderCard, width: 1)
          boxShadow: [
            BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),]
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isNew)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.circle,
                size: 10,
                color: PaletteColor.darkBlue,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardTitleText(
                    text: title,
                    size: CardTitleText.H6
                ),
                SizedBox(height: 4),
                DescriptionText(
                    text: content,
                    size: DescriptionText.P2
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}