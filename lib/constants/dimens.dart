import 'package:flutter/material.dart';

abstract class AppPaddings {
  /// Paddings for all offsets

  static const allPaddingXXL = EdgeInsets.all(AppSizes.sizeXXL);
  static const allPaddingXL = EdgeInsets.all(AppSizes.sizeXL);
  static const allPaddingL = EdgeInsets.all(AppSizes.sizeL);
  static const allPaddingM = EdgeInsets.all(AppSizes.sizeM);
  static const allPaddingSM = EdgeInsets.all(AppSizes.size12);
  static const allPaddingSSM = EdgeInsets.all(AppSizes.sizeSSM);
  static const allPaddingS = EdgeInsets.all(AppSizes.sizeS);
  static const allPaddingXS = EdgeInsets.all(AppSizes.sizeXS);
  static const allPaddings12 = EdgeInsets.all(AppSizes.size12);
  static const allPadding20 = EdgeInsets.all(AppSizes.size20);
  static const allPadding30 = EdgeInsets.all(AppSizes.size30);
}

abstract class AppBordersRadius {
  ///Circular radii variations

  static const radiusCircularXS = Radius.circular(4);
  static const radiusCircularVL = Radius.circular(6);
  static const radiusCircularS = Radius.circular(8);
  static const radiusCircularSSM = Radius.circular(10);
  static const radiusCircularSM = Radius.circular(12);
  static const radiusCircularM = Radius.circular(16);
  static const radiusCircular20 = Radius.circular(20);
  static const radiusCircularL = Radius.circular(24);
  static const radiusCircular30 = Radius.circular(30);
  static const radiusCircular36 = Radius.circular(36);
  static const radiusCircular45 = Radius.circular(45);

  /// Variations of border radius where all radii are radius

  static const borderRadiusAllXS = BorderRadius.all(radiusCircularXS);
  static const borderRadiusAllVL = BorderRadius.all(radiusCircularVL);
  static const borderRadiusAllS = BorderRadius.all(radiusCircularS);
  static const borderRadiusAllSSM = BorderRadius.all(radiusCircularSSM);
  static const borderRadiusAllSM = BorderRadius.all(radiusCircularSM);
  static const borderRadiusAll20 = BorderRadius.all(radiusCircular20);
  static const borderRadiusAllM = BorderRadius.all(radiusCircularM);
  static const borderRadiusAllL = BorderRadius.all(radiusCircularL);
  static const borderRadiusAll30 = BorderRadius.all(radiusCircular30);
  static const borderRadiusAll36 = BorderRadius.all(radiusCircular36);
  static const borderRadiusAll45 = BorderRadius.all(radiusCircular45);
}

abstract class AppSizes {
  static const double sizeZero = 0;
  static const double sizeXS = 4;
  static const double size6 = 6;
  static const double sizeS = 8;
  static const double sizeSSM = 10;
  static const double size12 = 12;
  static const double sizeM = 16;
  static const double size20 = 20;
  static const double sizeL = 24;
  static const double size30 = 30;
  static const double sizeXL = 32;
  static const double size40 = 40;
  static const double sizeXXL = 48;
  static const double size50 = 50;
}
