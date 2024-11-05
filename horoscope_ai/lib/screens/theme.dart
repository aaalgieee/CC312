import 'package:flutter/cupertino.dart';

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

Color backgroundColor(BuildContext context) {
  return isDarkMode(context)
      ? const Color(0xFF201d1c)
      : const Color(0xFFdedad1);
}

Color textColor(BuildContext context) {
  return isDarkMode(context) ? CupertinoColors.white : CupertinoColors.black;
}

Color buttonColor(BuildContext context) {
  return isDarkMode(context)
      ? const Color(0xFF4c4b4a)
      : const Color(0xFFf2f2f2);
}
