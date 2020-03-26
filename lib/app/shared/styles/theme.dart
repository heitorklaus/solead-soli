import 'package:flutter/material.dart';

import 'main_colors.dart';

ThemeData mainTheme = ThemeData().copyWith(
    primaryColor: MainColors.cielo,
    accentColor: MainColors.cielo,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: MainColors.cielo),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ));
