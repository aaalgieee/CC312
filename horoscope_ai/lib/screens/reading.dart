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
      child: SafeArea(
        child: DefaultTextStyle(
          style: TextStyle(
            color: textColor(context),
            fontFamily: '.SF Pro Text',
            decoration: TextDecoration.none,
          ),
          child: Column(
            children: [
              // Custom back button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      onBack();
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
              ),
              // Rest of your existing content
              Expanded(
                child: _buildContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
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
                const SizedBox(height: 16),
                Text(
                  selectedSign,
                  style: TextStyle(
                    color: textColor(context),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  getDateRange(selectedSign),
                  style: TextStyle(
                    color: textColor(context).withOpacity(0.7),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Scrollable content in circular container
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildMarkdownContent(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
