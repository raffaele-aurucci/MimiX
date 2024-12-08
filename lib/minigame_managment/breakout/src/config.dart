import 'package:flutter/material.dart';

const mimixBlue = Color(0xff1e6091);

const ballColor = Color(0xff1e6091);
const batColor = Color(0xff1e6091);
const neutralBrickColor = Color(0xff1e6091);
const bigBallBrickColor = Color(0xff16ef0e);
const bigBatBrickColor = Color(0xffffe14b);

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