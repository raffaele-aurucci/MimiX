import 'package:flutter/material.dart';

import '../../utils/view/widgets/cards/notification_card.dart';
import '../../utils/view/widgets/texts/header_text.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
        canPop: false,
        child: Scaffold(
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
                    title: 'Daily Training Reminder',
                    content:
                    "Time to train your facial expressions! Take 5 minutes for today's exercise.",
                  ),
                  SizedBox(height: 16),
                  // Other Notifications
                  NotificationCard(
                    isNew: false,
                    title: 'Feedback on Results',
                    content:
                    "You've improved eyebrow movement by 15% compared to last week!",
                  ),
                  SizedBox(height: 16),
                  NotificationCard(
                    isNew: false,
                    title: 'Virtual Rewards',
                    content:
                    "Congratulations! You've completed 7 consecutive days of training. Keep it going!",
                  ),
                ],
              ),
            ),
        )
      )
    );
  }
}