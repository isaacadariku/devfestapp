// Extension on BuildContext

import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// Returns the width of the screen
  double get adaptivePageConstraint {
    final width = MediaQuery.of(this).size.width;

    return isDesktopDisplay ? 600.0 : width;
  }

  /// Returns true if the screen is a desktop
  bool get isDesktopDisplay => MediaQuery.of(this).size.width > 600;

  /// Returns true if the screen is a mobile
  bool get isMobileDisplay => MediaQuery.of(this).size.width < 600;

  /// Returns true if the screen is a tablet
  bool get isTabletDisplay =>
      MediaQuery.of(this).size.width > 600 &&
      MediaQuery.of(this).size.width < 1200;

  /// Returns the current theme
  ThemeData get theme => Theme.of(this);

  /// Returns the current text theme
  TextTheme get textTheme => Theme.of(this).textTheme;
}
