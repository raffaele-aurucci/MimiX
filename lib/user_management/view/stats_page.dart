import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/view/widgets/cards/stats_card.dart';
import '../../utils/view/widgets/texts/header_text.dart';
import '../../utils/view/widgets/user_level.dart';
import '../beans/user_provider.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  ],
                ),
                const SizedBox(height: 20),
                // First line: two blocks
                const Row(
                  children: [
                    Expanded(
                      child: CardStats(cardStats: CardStats.dailyStats), // Daily time card
                    ),
                    SizedBox(width: 4), // Spaziatura tra i blocchi
                    Expanded(
                      child: CardStats(cardStats: CardStats.monthlyStats), // Monthly time card
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // One block for second line
                const CardStats(cardStats: CardStats.weeklyStats), // Single block: weekly time card
              ],
            ),
        )
        ),
    );
  }
}