import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tla_1n2/screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Todo App - TLA 1 & 2',
      theme: CupertinoThemeData(primaryColor: CupertinoColors.activeBlue),
      home: HomeScreen(),
    );
  }
}
