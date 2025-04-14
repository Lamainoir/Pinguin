import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double defaultPadding;
  static late double defaultMargin;
  static late double defaultRadius;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    // Valeurs par défaut basées sur la taille de l'écran
    defaultPadding = blockSizeHorizontal * 4;
    defaultMargin = blockSizeHorizontal * 2;
    defaultRadius = blockSizeHorizontal * 2;
  }

  // Méthodes pour obtenir des tailles responsives
  static double getResponsiveWidth(double percentage) {
    return screenWidth * (percentage / 100);
  }

  static double getResponsiveHeight(double percentage) {
    return screenHeight * (percentage / 100);
  }

  static double getResponsiveFontSize(double baseSize) {
    return baseSize * (screenWidth / 375); // 375 est la largeur de référence (iPhone SE)
  }

  // Méthodes pour vérifier la taille de l'écran
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 650;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  // Méthodes pour obtenir des espacements responsifs
  static EdgeInsets getPadding({
    double horizontal = 4,
    double vertical = 4,
  }) {
    return EdgeInsets.symmetric(
      horizontal: blockSizeHorizontal * horizontal,
      vertical: blockSizeVertical * vertical,
    );
  }

  static EdgeInsets getMargin({
    double horizontal = 2,
    double vertical = 2,
  }) {
    return EdgeInsets.symmetric(
      horizontal: blockSizeHorizontal * horizontal,
      vertical: blockSizeVertical * vertical,
    );
  }

  // Méthode pour obtenir un BorderRadius responsive
  static BorderRadius getBorderRadius({double radius = 2}) {
    return BorderRadius.circular(blockSizeHorizontal * radius);
  }
} 