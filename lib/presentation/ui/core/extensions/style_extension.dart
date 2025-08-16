import 'package:flutter/material.dart';

import '../colors.dart';


extension StyleExtension on TextStyle {
  TextStyle get secondary => copyWith(color: AppColors.grey);

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}