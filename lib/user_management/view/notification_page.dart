import 'package:flutter/material.dart';

import '../../utils/view/widgets/cards/notification_card.dart';
import '../../utils/view/widgets/texts/header_text.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderText(text: 'Notification', size: HeaderText.H4),
                  ],),

                SizedBox(height: 45),

                // New Notification Card
                NotificationCard(
                  isNew: true,
                  title: 'New notification',
                  content:
                  'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, ipsum dolor',
                ),
                SizedBox(height: 16),
                // Other Notifications
                NotificationCard(
                  isNew: false,
                  title: 'Notification',
                  content:
                  'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, ipsum dolor',
                ),
                SizedBox(height: 16),
                NotificationCard(
                  isNew: false,
                  title: 'Notification',
                  content:
                  'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, ipsum dolor',
                ),
              ],
            ),
          ),
      )
    );
  }
}