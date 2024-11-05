// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:horoscope_ai/screens/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Astrologer AI',
      home: Onboarding(),
    );
  }
}
