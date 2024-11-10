// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'theme.dart';

class Reading extends StatelessWidget {
  final String selectedSign;
  final VoidCallback onBack; // Add this line

  const Reading({
    super.key,
    required this.selectedSign,
    required this.onBack, // Add this line
  });

  // Map zodiac signs to their date ranges
  String getDateRange(String sign) {
    final Map<String, String> dateRanges = {
      'Aries': '21 Mar - 19 Apr',
      'Taurus': '20 Apr - 20 May',
      'Gemini': '21 May - 20 Jun',
      'Cancer': '21 Jun - 22 Jul',
      'Leo': '23 Jul - 22 Aug',
      'Virgo': '23 Aug - 22 Sep',
      'Libra': '23 Sep - 22 Oct',
      'Scorpio': '23 Oct - 21 Nov',
      'Sagittarius': '22 Nov - 21 Dec',
      'Capricorn': '22 Dec - 19 Jan',
      'Aquarius': '20 Jan - 18 Feb',
      'Pisces': '19 Feb - 20 Mar',
    };
    return dateRanges[sign] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor(context),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: backgroundColor(context),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            onBack(); // Call the callback
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.back,
                color: textColor(context),
                size: 28,
              ),
              Text(
                'Back',
                style: TextStyle(
                  color: textColor(context),
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Center(
                child: Image.asset(
                  'assets/signs/$selectedSign.png',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    Text(
                      selectedSign,
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    Text(
                      getDateRange(selectedSign),
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle
                          .copyWith(
                              color: CupertinoColors.systemGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              CupertinoFormSection(
                header: Text('Lucky Numbers'),
                children: [
                  CupertinoFormRow(
                    child: Text('5, 7 and 3'),
                  ),
                ],
              ),
              CupertinoFormSection(
                header: Text('Unlucky Numbers'),
                children: [
                  CupertinoFormRow(
                    child: Text('9 and 1'),
                  ),
                ],
              ),
              CupertinoFormSection(
                header: Text('Lucky Colour'),
                children: [
                  CupertinoFormRow(
                    child: Text('Red and Blue'),
                  ),
                ],
              ),
              CupertinoFormSection(
                header: Text('Unlucky Colour'),
                children: [
                  CupertinoFormRow(
                    child: Text('Black'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
