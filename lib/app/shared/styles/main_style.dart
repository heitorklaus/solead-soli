import 'package:flutter/material.dart';

import 'text_style_generator.dart';
import 'main_colors.dart';

/// THESE TEXT STYLES COMES FROM FLUI
/// It was rose up to make easy to reproduce the styles applied by UI/UX staff
//----------------------------------------------------------------- Headings
final heading16Bold = TextStyleGenerator().getMontserratStyle(size: 16, color: Colors.black, weight: FontWeight.w700);

final ubuntu16WhiteBold500 = TextStyleGenerator().getUbuntuStyle(size: 16, color: Colors.white, weight: FontWeight.w500);

final ubuntu17WhiteBold500 = TextStyleGenerator().getUbuntuStyle(size: 17, color: Colors.white, weight: FontWeight.w300);

final ubuntu16BlueBold500 = TextStyleGenerator().getUbuntuStyle(size: 18, color: MainColors.cielo, weight: FontWeight.w500);

final ubuntu16BlackBold500 = TextStyleGenerator().getUbuntuStyle(size: 16, color: Colors.black, weight: FontWeight.w500);

final ubuntu14WhiteLight100 = TextStyleGenerator().getUbuntuStyle(size: 14, color: Colors.white, weight: FontWeight.w100);

final ubuntu14BlackLight100 = TextStyleGenerator().getUbuntuStyle(size: 14, color: MainColors.cloudy300, weight: FontWeight.w100);

final museo14Sky700 = TextStyleGenerator().getMontserratStyle(color: MainColors.cielo, size: 12, weight: FontWeight.w700);

final ubuntu10BlackLight100 = TextStyleGenerator().getUbuntuStyle(size: 10, color: Colors.yellow, weight: FontWeight.w100);

final ubuntu35WhiteLight100 = TextStyleGenerator().getUbuntuStyle(size: 28, color: Colors.yellow, weight: FontWeight.w100);

//----------------------------------------------------------------- LEAGACY Small Texts

final legacySmallText10RegularCloudy300 = TextStyleGenerator().getUbuntuStyle(
  color: MainColors.cloudy[300],
  size: 10,
);

//----------------------------------------------------------------- Buttons Small

final buttonSmallCielo = TextStyleGenerator().getUbuntuStyle(
  color: MainColors.cielo,
  weight: FontWeight.w500,
);

final buttonSmallWhite = TextStyleGenerator().getUbuntuStyle(
  color: Colors.white,
  weight: FontWeight.w500,
);

final buttonSmallRed = TextStyleGenerator().getUbuntuStyle(
  color: MainColors.danger[400],
  weight: FontWeight.w500,
);

//----------------------------------------------------------------- Buttons Large

final buttonLargeWhite = TextStyleGenerator().getUbuntuStyle(
  color: Colors.white,
  size: 18,
  weight: FontWeight.w500,
);

final buttonLargeBlue = TextStyleGenerator().getUbuntuStyle(
  color: Colors.blue,
  size: 18,
  weight: FontWeight.w500,
);
