import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:signal/src/features/common/presentation/colors.dart';

class Styles {
  const Styles._();

  static const edgeInsetAll16 = EdgeInsets.all(16);
  static const edgeInsetAll10 = EdgeInsets.all(10);
  static const edgeInsetAll7 = EdgeInsets.all(7);
  static const edgeInsetAll5 = EdgeInsets.all(5);
  static const edgeInsetAll3 = EdgeInsets.all(3);
  static const edgeInsetAll20 = EdgeInsets.all(20);
  static const edgeInsetAll0 = EdgeInsets.zero;
  static const edgeInsetHorizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const edgeInsetVertical16 = EdgeInsets.symmetric(vertical: 16);
  static const edgeInsetHorizontal5 = EdgeInsets.symmetric(horizontal: 5);
  static const edgeInsetVertical5 = EdgeInsets.symmetric(vertical: 5);
  static const edgeInsetHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const edgeInsetVertical10 = EdgeInsets.symmetric(vertical: 10);

  static const formFieldPadding = EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 18,
  );

  static const stadiumBorder = BorderRadius.all(Radius.circular(30));

  static const formFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: stadiumBorder,
  );

  static const focusedFormFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primary, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

  static const navBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
  );

  static const homeCardGradient = SweepGradient(
    center: Alignment.topLeft,
    colors: <Color>[
      AppColors.secondary,
      AppColors.primary,
    ],
    stops: <double>[0, 0.4],
    transform: GradientRotation(math.pi * 2),
  );

  static const defaultBorderRadius = BorderRadius.all(Radius.circular(20));

  static const formBorderRadius = BorderRadius.all(Radius.circular(24));
}
