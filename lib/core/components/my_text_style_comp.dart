import 'package:fireapp3/core/constants/color_const.dart';
import 'package:fireapp3/core/constants/font_const.dart';
import 'package:flutter/material.dart';

class MyTextStyleComp {
  static get showModalTextStyle => TextStyle(
    color: ColorConst.scaffoldBackground,
        fontSize: FontConst.kSmallFont,
        fontWeight: FontWeight.bold,
      );
  
  static get loginForgotAndCreateTextStyle => const TextStyle(
    color: ColorConst.scaffoldBackground,
        fontWeight: FontWeight.bold,
      );
}
