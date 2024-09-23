import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'TLA 2 - State Management',
      home: AnimatedTextApp(),
    );
  }
}

class AnimatedTextApp extends StatefulWidget {
  const AnimatedTextApp({super.key});

  @override
  _AnimatedTextAppState createState() => _AnimatedTextAppState();
}

class _AnimatedTextAppState extends State<AnimatedTextApp> {
  String _displayText = 'Hello World!';
  final TextEditingController _textController = TextEditingController();

  void _updateText() {
    setState(() {
      _displayText = _textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('TLA 2 - State Management'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.5),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  _displayText,
                  key: ValueKey<String>(_displayText),
                  style: const TextStyle(fontSize:35, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  
                ),
              ),
              const SizedBox(height: 30),
              CupertinoTextField(
                controller: _textController,
                placeholder: 'Enter new text',
                onSubmitted: (_) => _updateText(),
                padding: const EdgeInsets.all(12.0),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: () {
                  _updateText();
                  _textController.clear();
                },
                child: const Text('Update Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
