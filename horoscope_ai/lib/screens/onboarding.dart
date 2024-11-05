import 'package:flutter/cupertino.dart';
import 'package:horoscope_ai/screens/home.dart';
import 'dart:math' as math;
import 'package:horoscope_ai/screens/theme.dart';
//import 'package:connectivity_plus/connectivity_plus.dart';

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

    //_checkInternetConnectiion();
  }

  /*Future<void> _checkInternetConnectiion() async {
    final connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text(
                'Please check your internet connection and try again later.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
*/

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

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor(context),
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
                        isDarkMode:
                            isDarkMode(context)), // Pass isDarkMode here
                    size: Size(MediaQuery.of(context).size.width * 0.8, 300),
                  ),
                ),
              ),
              Text(
                'Welcome to Astro Buddy!',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: textColor(context)),
              ),
              const SizedBox(height: 10),
              Text(
                'Find your zodiac sign and learn about your traits and lucky numbers or lucky colors which bring good fortune to you. And also you can read your horoscope and plan your day.',
                style: TextStyle(fontSize: 15, color: textColor(context)),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor(context)),
                    ),
                    const SizedBox(width: 10),
                    ChevronAnimation(textColor: textColor(context))
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
