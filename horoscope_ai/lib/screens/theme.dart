import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Always return false for dark mode
bool isDarkMode(BuildContext context) {
  return false; // Force light mode
}

Color backgroundColor(BuildContext context) {
  return const Color(0xFFdedad1); // Light mode background
}

Color textColor(BuildContext context) {
  return Platform.isIOS
      ? CupertinoColors.black
      : Colors.black; // Light mode text
}

Color buttonColor(BuildContext context) {
  return const Color(0xFFf2f2f2); // Light mode button
}
