import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/widgets/progress_bar.dart';
import 'package:mimix_app/utils/view/widgets/texts/card_title_text.dart';
import 'package:mimix_app/utils/view/widgets/texts/description_text.dart';

import '../../app_palette.dart';

class CardStats extends StatelessWidget {

  static const int dailyStats = 0;
  static const int weeklyStats = 1;
  static const int monthlyStats = 2;

  final int cardStats;

  const CardStats({super.key, required this.cardStats});

  @override
  Widget build(BuildContext context) {
    if(cardStats == 0)
      return buildDailyCard();
    else if(cardStats == 1)
      return buildWeeklyCard();
    else
      return buildMonthlyCard();
  }
}

// Build weekly card
Widget buildWeeklyCard() {
  return _buildCard(
    icon: Icons.calendar_today,
    title: 'Weekly time',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDayProgress('MON', 0.6),
            _buildDayProgress('TUE', 0.4),
            _buildDayProgress('WED', 0.8),
            _buildDayProgress('THU', 0.2),
            _buildDayProgress('FRI', 0.9),
            _buildDayProgress('SAT', 0.3),
            _buildDayProgress('SUN', 0.7),
          ],
        ),
      ],
    ),
  );
}

// Build progress bar vertical for weekly card
Widget _buildDayProgress(String day, double progress) {
  return Column(
    children: [
      ProgressBar(progress: progress,
          height: ProgressBar.heightBigCard,
          width: ProgressBar.statsProgressBarWidth,
          orientation: "vertical"
      ),
      SizedBox(height: 8),
      DescriptionText(
          text: day,
          size: DescriptionText.P2
      )
    ],
  );
}

// Build dayly card
Widget buildDailyCard() {
  return _buildCard(
    icon: Icons.access_time,
    title: 'Daily time',
    child: Container(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center, // Centra i widget all'interno del cerchio
            children: [
              CustomPaint(
                size: const Size(150, 150),
                painter: RoundedCircularProgressPainter(
                  progress: 0.7,
                  progressColor: PaletteColor.darkBlue,
                  strokeWidth: 12
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center, // To put the text in the circular progress bar
                children: [
                  DescriptionText(
                    text: 'Minutes',
                    size: DescriptionText.P2,
                  ),
                  CardTitleText(
                    text: '45',
                    size: CardTitleText.H6,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

// Build monthly card
Widget buildMonthlyCard() {
  return _buildCard(
    icon: Icons.bar_chart,
    title: 'Monthly time',
    child: Container(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 100,
              child: Image.asset('assets/images/plot.png')
          ),
          const SizedBox(height: 16),
          const DescriptionText(
              text: 'Mean',
              size: DescriptionText.P2
          ),
          const CardTitleText(
            text: '195',
            size: CardTitleText.H6,
          ),
        ],
      ),
    )
  );
}

// Build general card
Widget _buildCard({
  required IconData icon,
  required String title,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: PaletteColor.whiteColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 5,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: PaletteColor.backgroundIcon,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                  icon,
                  color: PaletteColor.darkBlue,
                  size: 20
              ),
            ),
            SizedBox(width: 8),
            DescriptionText(
              text: title,
              size: DescriptionText.P2,
            )
          ],
        ),
        SizedBox(height: 25),
        child,
      ],
    ),
  );
}

class RoundedCircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final double strokeWidth;

  RoundedCircularProgressPainter({
    required this.progress,
    required this.progressColor,
    this.strokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = PaletteColor.progressBarBackground
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}