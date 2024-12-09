import 'package:flutter/material.dart';

import '../../../utils/view/app_palette.dart';

const clearBlue = Color(0xff1e6091);

const bigBallBrickColor = PaletteColor.errorMessage;
const bigBatBrickColor = PaletteColor.yellow;

const gameWidth = 1200.0;
const gameHeight = 1600.0;

const ballRadius = gameWidth * 0.02;

const batRadius = gameWidth * 0.02;
const batWidth = gameWidth * 0.2;
const batHeight = batRadius * 1;
const batStep = gameWidth * 0.03;

const brickGutter = gameWidth * 0.015;
const brickWidth = (gameWidth - (brickGutter * (10 + 1))) / 10;
const brickHeight = gameHeight * 0.03;

const difficultyModifier = 1.03;