import 'package:flutter/material.dart';

class Dimension {

  static const double smallMargin = 4.0;
  static const double regularMargin = 8.0;
  static const double parentMargin = 10.0;
  static const double largeMargin = 20.0;

  static const double borderRadius = 8.0;
  static const double smallBorderRadiusRounded = 10.0;
  static const double borderRadiusRounded = 20.0;
  static const double textFieldHeight = 32.0;

  static get regularPadding => EdgeInsets.all(regularMargin);
  static get smallPadding => EdgeInsets.all(smallMargin);
  static get largePadding => EdgeInsets.all(parentMargin);
}