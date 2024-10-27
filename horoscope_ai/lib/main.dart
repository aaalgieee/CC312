// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Zodiac App',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemGrey,
      ),
      home: ZodiacIntroScreen(),
    );
  }
}

class ChevronAnimation extends StatefulWidget {
  final Color textColor;

  const ChevronAnimation({
    super.key,
    required this.textColor,
  });

  @override
  State<ChevronAnimation> createState() => _ChevronAnimationState();
}

class _ChevronAnimationState extends State<ChevronAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: Icon(CupertinoIcons.right_chevron, color: widget.textColor),
        );
      },
    );
  }
}

class ZodiacIntroScreen extends StatelessWidget {
  const ZodiacIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final backgroundColor =
        isDarkMode ? const Color(0xFF201d1c) : const Color(0xFFdedad1);

    final textColor =
        isDarkMode ? CupertinoColors.white : CupertinoColors.black;

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: CustomPaint(
                    painter: ConstellationPainter(
                        isDarkMode: isDarkMode), // Pass isDarkMode here
                    size: Size(MediaQuery.of(context).size.width * 0.8, 300),
                  ),
                ),
              ),
              Text(
                'Know your Zodiac',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              SizedBox(height: 10),
              Text(
                'Find your zodiac sign and learn about your traits and lucky numbers or lucky colors which bring good fortune to you. And you can chat with astrologers and also you can read your horoscope and plan your day.',
                style: TextStyle(fontSize: 14, color: textColor),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // Add your onPressed logic here
                },
                child: Row(
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    SizedBox(width: 10),
                    ChevronAnimation(textColor: textColor)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConstellationPainter extends CustomPainter {
  final bool isDarkMode;

  ConstellationPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDarkMode ? CupertinoColors.white : CupertinoColors.black
      ..strokeWidth = 1;

    final dotPaint = Paint()
      ..color = isDarkMode ? CupertinoColors.white : CupertinoColors.black
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistent pattern
    final points = List.generate(
      15,
      (_) => Offset(
          random.nextDouble() * size.width, random.nextDouble() * size.height),
    );

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    for (final point in points) {
      canvas.drawCircle(
          point, 4, dotPaint); // Increased size of existing stars from 2 to 4
    }

    // Add phantom stars
    final phantomStarPaint = Paint()
      ..color = isDarkMode
          ? CupertinoColors.white.withOpacity(0.5)
          : CupertinoColors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 25; i++) {
      // Add 5 phantom stars
      final phantomPoint = Offset(
          random.nextDouble() * size.width, random.nextDouble() * size.height);
      canvas.drawCircle(phantomPoint, 1.5,
          phantomStarPaint); // Increased size of phantom stars from 5 to 10
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}