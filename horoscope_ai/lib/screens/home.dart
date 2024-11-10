// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme.dart';
import 'reading.dart';
import '/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSign = ref.watch(selectedSignProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return CupertinoPageScaffold(
        backgroundColor: backgroundColor(context),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: DefaultTextStyle(
              style: TextStyle(
                color: textColor(context),
                fontFamily: '.SF Pro Text',
                decoration: TextDecoration.none,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Text(
                    'Good Fortune!',
                    style: TextStyle(
                      color: textColor(context),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'What you want to know?',
                    style: TextStyle(
                      color: textColor(context),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    'Select your sign:',
                    style: TextStyle(
                      color: textColor(context),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(
                    height: 540.0,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      children: List.generate(12, (index) {
                        final sign = getSign(index);
                        final isSelected = selectedSign == sign;

                        return GestureDetector(
                          onTap: () => ref
                              .read(selectedSignProvider.notifier)
                              .state = sign,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF4c4b4a)
                                  : const Color(0xFFf2f2f2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/signs/$sign.png',
                                  height: 85.0,
                                  width: 85.0,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  sign,
                                  style: TextStyle(
                                    color: isSelected
                                        ? CupertinoColors.white
                                        : CupertinoColors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: const Color(0xFF1f9a61),
                        onPressed: (selectedSign.isEmpty || isLoading)
                            ? null
                            : () async {
                                try {
                                  ref.read(isLoadingProvider.notifier).state =
                                      true;
                                  await ref
                                      .read(generateHoroscopeProvider.future);

                                  if (!context.mounted) return;

                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => Reading(
                                        selectedSign: selectedSign,
                                        horoscopeText:
                                            ref.read(horoscopeTextProvider),
                                        onBack: () {
                                          ref
                                              .read(
                                                  selectedSignProvider.notifier)
                                              .state = '';
                                        },
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Failed to generate horoscope. Please try again.'),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                } finally {
                                  if (context.mounted) {
                                    ref.read(isLoadingProvider.notifier).state =
                                        false;
                                  }
                                }
                              },
                        child: isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CupertinoActivityIndicator(
                                    color: CupertinoColors.black,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Reading your futune...',
                                    style: TextStyle(
                                      color: CupertinoColors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Get Your Reading',
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  String getSign(int index) {
    final List<String> signs = [
      'Aries',
      'Taurus',
      'Gemini',
      'Cancer',
      'Leo',
      'Virgo',
      'Libra',
      'Scorpio',
      'Sagittarius',
      'Capricorn',
      'Aquarius',
      'Pisces'
    ];

    // Handle invalid indices by returning first sign
    if (index < 0 || index >= signs.length) {
      return signs[0];
    }

    return signs[index];
  }
}
