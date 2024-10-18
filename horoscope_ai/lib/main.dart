import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Swiss Design App',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemRed,
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: 'Helvetica'),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Swiss Design'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    color: index % 2 == 0
                        ? CupertinoColors.systemRed
                        : CupertinoColors.black,
                    child: Center(
                      child: Text(
                        'Grid ${index + 1}',
                        style: const TextStyle(
                            color: CupertinoColors.white, fontSize: 24),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: CupertinoColors.systemGrey6,
              child: const Text(
                'Swiss Design Principles',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
