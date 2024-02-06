import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Shared/Fonts/FontModel.dart';

enum TextLanguage {
  arabic,
  english,
}

enum Gender {
  male,
  female,
}

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.textScaleFactor,
    this.language,
    this.overflow,
    this.maxLines,
    this.capitalizeFirst = false,
  });

  static TextLanguage defaultLanguage = TextLanguage.english;
  final String text;
  final bool capitalizeFirst;
  final TextLanguage? language;
  final double? textScaleFactor;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      capitalizeFirst ? text.capitalize ?? text : text,
      overflow: overflow,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      style: style == null
          ? FontStyles.body
          : style!.fontFamily == null
              ? style!.copyWith(
                  fontFamily: FontFamily.regular,
                )
              : style,
    );
  }
}
