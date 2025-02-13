import 'package:flutter/material.dart';

const gameWidth = 1210.0;
const gameHeight = 1600.0;

// ball
const ballRadius = gameWidth * 0.02;
const ballBlueRect = Rect.fromLTWH(452,2,22,22);
const ballRedRect = Rect.fromLTWH(476,2,22,22);

// bat
const batWidth = gameWidth * 0.2;
const batHeight = gameWidth * 0.035;
const batStep = gameWidth * 0.02;
// Coordinates and size of bat
const batRect = Rect.fromLTWH(2, 53, 104, 24);

// brick
const brickGutter = gameWidth * 0.015;
const brickWidth = (gameWidth - (brickGutter * (10 + 1))) / 10;
const brickHeight = gameHeight * 0.03;

const difficultyModifier = 1.03;

const difficultyModifier = 1.03;