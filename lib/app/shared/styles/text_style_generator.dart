import 'package:flutter/cupertino.dart';
import 'main_colors.dart';
import 'font_name.dart';

class TextStyleGenerator {
  static final TextStyleGenerator _instance = TextStyleGenerator._internal();

  final Map<String, TextStyle> _generatedStyles = Map();

  TextStyleGenerator._internal();

  factory TextStyleGenerator() {
    return _instance;
  }

  TextStyle getStyle({
    Color color,
    FontName font = FontName.UBUNTU,
    double size = 14.0,
    FontWeight weight = FontWeight.normal,
  }) {
    color = color == null ? MainColors.cloudy : color;
    font = font == null ? FontName.UBUNTU : font;
    size = size == null ? 14.0 : size;
    weight = weight == null ? FontWeight.normal : weight;

    String styleKey = font.toString() +
        size.toString() +
        color.toString() +
        weight.toString();

    TextStyle textStyle;

    if (_generatedStyles.containsKey(styleKey)) {
      textStyle = _generatedStyles[styleKey];
    } else {
      textStyle = TextStyle(
        color: color,
        fontFamily: this._getFontName(font),
        fontSize: size,
        fontWeight: weight,
      );
      this._generatedStyles[styleKey] = textStyle;
    }

    return textStyle;
  }

  TextStyle getUbuntuStyle({
    Color color,
    double size,
    FontWeight weight,
  }) {
    return this.getStyle(
      color: color,
      size: size,
      weight: weight,
    );
  }

  TextStyle getMontserratStyle({
    Color color,
    double size,
    FontWeight weight,
  }) {
    return this.getStyle(
      color: color,
      size: size,
      weight: weight,
      font: FontName.MUSEO,
    );
  }

  String _getFontName(FontName font) {
    switch (font) {
      case FontName.UBUNTU:
        return 'Ubuntu';
      case FontName.MUSEO:
        return 'Museo';
      default:
        print('Font not implemented.');
        return '';
    }
  }
}
