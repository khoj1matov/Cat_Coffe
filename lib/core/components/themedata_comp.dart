import 'package:fireapp3/core/constants/color_const.dart';
import 'package:flutter/material.dart';

class ThemeComp {
  static ThemeData get myTheme => ThemeData(
        colorScheme: const ColorScheme.light(
          primary: ColorConst.scaffoldBackground,
        ),
      );
}
