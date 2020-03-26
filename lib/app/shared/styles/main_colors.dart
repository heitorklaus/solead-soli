import 'package:flutter/material.dart';

class MainColors {
  /// Package: Primary Colors
  static const MaterialColor cielo = MaterialColor(
    _cieloPrimaryValue,
    <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFDEF5FF),
      200: const Color(0xFF71D4FF),
      300: const Color(0xFF00AEEF),
      400: const Color(_cieloPrimaryValue),
      500: const Color(0xFF145EB3),
      600: const Color(0xFF204986),
    },
  );
  static const int _cieloPrimaryValue = 0xFF2184AA;
  static const Color cielo50 = Color(0xFFFFFFFF);
  static const Color cielo100 = Color(0xFFDEF5FF);
  static const Color cielo200 = Color(0xFF71D4FF);
  static const Color cielo300 = Color(0xFF00AEEF);
  static const Color cielo400 = Color(_cieloPrimaryValue);
  static const Color cielo500 = Color(0xFF145EB3);
  static const Color cielo600 = Color(0xFF204986);

  /// Package: Primary Colors
  static const MaterialColor cloudy = MaterialColor(
    _cloudyPrimaryValue,
    <int, Color>{
      20: const Color(0xFFFBFBFC),
      50: const Color(0xFFF2F4F8),
      100: cloudy100,
      200: cloudy200,
      300: cloudy300,
      400: const Color(_cloudyPrimaryValue),
      500: const Color(0xFF353A40),
      600: const Color(0xFF231F20),
    },
  );
  static const int _cloudyPrimaryValue = 0xFF5A646E;
  static const Color cloudy100 = Color(0xFFEAEEF3);
  static const Color cloudy200 = Color(0xFFC5CED7);
  static const Color cloudy300 = Color(0xFF808C99);
  static const Color cloudy400 = Color(_cloudyPrimaryValue);

  /// Package: Primary Colors
  static const MaterialColor success = MaterialColor(
    _successPrimaryValue,
    <int, Color>{
      100: success100,
      200: const Color(0xFF96D5AE),
      300: const Color(0xFF43B977),
      400: const Color(_successPrimaryValue),
      500: const Color(0xFF007B3E),
      600: const Color(0xFF005734),
    },
  );
  static const int _successPrimaryValue = 0xFF009E55;
  static const Color success100 = Color(0xFFE5F5EB);

  /// Package: Primary Colors
  static const MaterialColor danger = MaterialColor(
    _dangerPrimaryValue,
    <int, Color>{
      100: danger100,
      200: const Color(0xFFF59C99),
      300: const Color(0xFFE9655B),
      400: const Color(_dangerPrimaryValue),
      500: const Color(0xFFBD281E),
      600: const Color(0xFF931C1A),
    },
  );
  static const int _dangerPrimaryValue = 0xFFDC392A;
  static const Color danger100 = Color(0xFFFFDCDB);

  /// Package: Primary Colors
  static const MaterialColor alert = MaterialColor(
    _alertPrimaryValue,
    <int, Color>{
      100: const Color(0xFFFFF3E2),
      200: const Color(0xFFFFD294),
      300: const Color(0xFFFEA93A),
      400: const Color(_alertPrimaryValue),
      500: const Color(0xFFEA7F06),
      600: const Color(0xFFD16B05),
    },
  );
  static const int _alertPrimaryValue = 0xFFF98F25;

  /// Package: Secondary Colors
  static const MaterialColor sunset = MaterialColor(
    _sunsetPrimaryValue,
    <int, Color>{
      100: const Color(0xFFFFE0E7),
      200: const Color(0xFFFA9297),
      300: const Color(0xFFF74953),
      400: const Color(_sunsetPrimaryValue),
      500: const Color(0xFFCF0E2A),
      600: const Color(0xFF9E102C),
    },
  );
  static const int _sunsetPrimaryValue = 0xFFEE2737;

  /// Package: Secondary Colors
  static const MaterialColor twilight = MaterialColor(
    _twilightPrimaryValue,
    <int, Color>{
      100: const Color(0xFFF1DFF7),
      200: const Color(0xFFC59ADB),
      300: const Color(0xFF8343A3),
      400: const Color(_twilightPrimaryValue),
      500: const Color(0xFF5C2579),
      600: const Color(0xFF3C0459),
    },
  );
  static const int _twilightPrimaryValue = 0xFF742E98;

  /// Package: Secondary Colors
  static const MaterialColor pistachio = MaterialColor(
    _pistachioPrimaryValue,
    <int, Color>{
      100: const Color(0xFFFAFBDD),
      200: const Color(0xFFE9EE94),
      300: const Color(0xFFE0E566),
      400: const Color(_pistachioPrimaryValue),
      500: const Color(0xFF909612),
      600: const Color(0xFF5F6305),
    },
  );
  static const int _pistachioPrimaryValue = 0xFFB2B827;

  /// Package: Complementary Colors
  static const MaterialColor dawn = MaterialColor(
    _dawnPrimaryValue,
    <int, Color>{
      100: const Color(0xFFFBE9E7),
      200: const Color(0xFFFFAB91),
      300: const Color(0xFFFF7043),
      400: const Color(_dawnPrimaryValue),
      500: const Color(0xFFD84315),
      600: const Color(0xFF992400),
    },
  );
  static const int _dawnPrimaryValue = 0xFFF4511E;

  /// Package: Complementary Colors
  static const MaterialColor rainbow = MaterialColor(
    _rainbowPrimaryValue,
    <int, Color>{
      100: const Color(0xFFFCE8F1),
      200: const Color(0xFFF587B7),
      300: const Color(0xFFE63C86),
      400: const Color(_rainbowPrimaryValue),
      500: const Color(0xFFB30B55),
      600: const Color(0xFF80033A),
    },
  );
  static const int _rainbowPrimaryValue = 0xFFCB1364;

  /// Package: Complementary Colors
  static const MaterialColor sunshine = MaterialColor(
    _sunshinePrimaryValue,
    <int, Color>{
      100: const Color(0xFFFFF8E1),
      200: const Color(0xFFFFE183),
      300: const Color(0xFFFFCB29),
      400: const Color(_sunshinePrimaryValue),
      500: const Color(0xFFF09800),
      600: const Color(0xFFCC7400),
    },
  );
  static const int _sunshinePrimaryValue = 0xFFFFB402;

  /// Package: Complementary Colors
  static const MaterialColor beach = MaterialColor(
    _beachPrimaryValue,
    <int, Color>{
      100: const Color(0xFFE0F6FA),
      200: const Color(0xFF80D8EA),
      300: const Color(0xFF25BDDA),
      400: const Color(_beachPrimaryValue),
      500: const Color(0xFF00778F),
      600: const Color(0xFF014C62),
    },
  );
  static const int _beachPrimaryValue = 0xFF00A1C1;

  /// Package: Complementary Colors
  static const MaterialColor aurora = MaterialColor(
    _auroraPrimaryValue,
    <int, Color>{
      100: const Color(0xFFE0F2F1),
      200: const Color(0xFF80CBC4),
      300: const Color(0xFF26A69A),
      400: const Color(_auroraPrimaryValue),
      500: const Color(0xFF00695C),
      600: const Color(0xFF004D40),
    },
  );
  static const int _auroraPrimaryValue = 0xFF00897B;

  /// Package: Complementary Colors
  static const MaterialColor ocean = MaterialColor(
    _oceanPrimaryValue,
    <int, Color>{
      100: const Color(0xFFE8EAF6),
      200: const Color(0xFF9FA8DA),
      300: const Color(0xFF5C6BC0),
      400: const Color(_oceanPrimaryValue),
      500: const Color(0xFF283593),
      600: const Color(0xFF141B61),
    },
  );
  static const int _oceanPrimaryValue = 0xFF3949AB;

  /// Package: Complementary Colors
  static const MaterialColor storm = MaterialColor(
    _stormPrimaryValue,
    <int, Color>{
      100: const Color(0xFFE7E9EE),
      200: const Color(0xFFC2C9D7),
      300: const Color(0xFF9BA6BB),
      400: const Color(_stormPrimaryValue),
      500: const Color(0xFF384A74),
      600: const Color(0xFF2A375C),
    },
  );
  static const int _stormPrimaryValue = 0xFF5A6A8D;

  /// Package: Complementary Colors
  static const MaterialColor desert = MaterialColor(
    _desertPrimaryValue,
    <int, Color>{
      100: const Color(0xFFF9E9D1),
      200: const Color(0xFFE1C9AF),
      300: const Color(0xFFC2A689),
      400: const Color(_desertPrimaryValue),
      500: const Color(0xFF694A23),
      600: const Color(0xFF4E3013),
    },
  );
  static const int _desertPrimaryValue = 0xFF8B6B45;
}
