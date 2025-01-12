import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';
import 'package:mimix_app/utils/view/widgets/circular_progress_bar.dart';
import 'package:mimix_app/utils/view/widgets/texts/card_title_text.dart';

class ProfileImageWithLevel extends StatelessWidget {
  final AssetImage? profileImage; // accept an image from assets folder
  final int experienceLevel; // experience level
  final double experienceProgress; // experience progress

  const ProfileImageWithLevel({
    Key? key,
    this.profileImage,
    required this.experienceLevel,
    required this.experienceProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PaletteColor.powderBlue,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Adapt the witdh at the content
        children: [
          // Profile image
          CircleAvatar(
            radius: 20.0,
            backgroundImage: profileImage,
            backgroundColor: Colors.grey[200],
            child: profileImage == null
                ? const Icon(
              Icons.person, // Default icon
              size: 20.0,
              color: Colors.grey,
            )
                : null,
          ),

          const SizedBox(width: 6.0),

          // Circular bar progress
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(35, 35),
                painter: CircularProgressBar(
                  progress: experienceProgress,
                  strokeWidth: 3.5,
                ),
              ),

              CardTitleText(text: experienceLevel.toString(), size: CardTitleText.H5)
            ],
          ),
        ],
      ),
    );
  }
}
