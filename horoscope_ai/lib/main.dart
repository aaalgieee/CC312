// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_ai/screens/onboarding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // Ensure Flutter bindings are initialized before using platform channels
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize other services
  await dotenv.load(fileName: ".env");

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        theme: const CupertinoThemeData(
          brightness: Brightness.light, // Force light mode
          primaryColor: CupertinoColors.systemBlue,
        ),
        home: const Onboarding(),
      );
    } else {
      return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light, // Force light mode
          primarySwatch: Colors.blue,
        ),
        home: const Onboarding(),
      );
    }
  }
}
