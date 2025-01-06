import 'package:flame/extensions.dart';

const double gameWidth = 360.0;
const double gameHeight = 360.0;

class ImageConstants {
  static const String hyena='dino_run/hyena.png';
  static const String vulture='dino_run/vulture.png';
  static const String dino='dino_run/dino_blue.png';
  static const String scorpio='dino_run/scorpio.png';
  static const String plx1 = 'dino_run/plx-1.png';
  static const String plx2 = 'dino_run/plx-2.png';
  static const String plx3 = 'dino_run/plx-3.png';
  static const String plx4 = 'dino_run/plx-4.png';
  static const String plx5 = 'dino_run/plx-5.png';
  static const String plx6 = 'dino_run/plx-6.png';
}

class EnemyData {
  final Image image;
  final int nFrames;
  final double stepTime;
  final Vector2 textureSize;
  final double speedX;
  final bool canFly;
  final String name;

  const EnemyData({
    required this.image,
    required this.nFrames,
    required this.stepTime,
    required this.textureSize,
    required this.speedX,
    required this.canFly,
    required this.name
  });
}