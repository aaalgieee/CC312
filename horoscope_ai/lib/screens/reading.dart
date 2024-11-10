// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'theme.dart';

class Reading extends StatelessWidget {
  final String selectedSign;
  final String horoscopeText;
  final VoidCallback onBack;

  const Reading({
    super.key,
    required this.selectedSign,
    required this.horoscopeText,
    required this.onBack,
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

  Widget _buildMarkdownContent(BuildContext context) {
    // Remove first title by splitting on first occurrence of \n\n
    final parts = horoscopeText.split('\n\n');
    final contentWithoutFirstTitle =
        parts.length > 1 ? parts.sublist(1).join('\n\n') : horoscopeText;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MarkdownBody(
        data: contentWithoutFirstTitle,
        styleSheet: MarkdownStyleSheet(
          p: TextStyle(
            color: textColor(context),
            fontSize: 16,
            height: 1.5,
          ),
          h2: TextStyle(
            color: textColor(context),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 2,
          ),
          listBullet: TextStyle(
            color: textColor(context),
            fontSize: 16,
          ),
          blockquote: TextStyle(
            color: textColor(context).withOpacity(0.8),
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
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
        child: Column(
          children: [
            // Non-scrollable header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 40),
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
                ],
              ),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBackground.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          CupertinoColors.systemBackground,
                          CupertinoColors.systemGrey6,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            horoscopeText.contains('Error')
                                ? 'Please try again'
                                : 'Here is your fortune reading:',
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navTitleTextStyle
                                .copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                          child: _buildMarkdownContent(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
