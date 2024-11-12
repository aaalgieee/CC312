// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share_plus/share_plus.dart';
import 'theme.dart';
import '../services/gemini_service.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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

  Future<Uint8List?> _generateShareImage(
      BuildContext context, String summary) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(1080, 1080);

    // Use single background color
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = backgroundColor(context),
    );

    // Add subtle overlay pattern
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color = backgroundColor(context).withOpacity(0.1)
        ..style = PaintingStyle.fill,
    );

    // Load and draw zodiac sign image
    final ByteData imageData =
        await rootBundle.load('assets/signs/$selectedSign.png');
    final Uint8List bytes = imageData.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();

    // Draw image at the top center
    final imageSize = Size(325, 325);
    final imageRect = Rect.fromLTWH(
      (size.width - imageSize.width) / 2,
      40, // Position from top
      imageSize.width,
      imageSize.height,
    );

    // Add circular background for the image
    canvas.drawCircle(
      Offset(size.width / 2, imageRect.center.dy),
      45, // Slightly larger than the image radius
      Paint()..color = CupertinoColors.white.withOpacity(0.2),
    );

    // Draw the image
    canvas.drawImageRect(
      frame.image,
      Rect.fromLTWH(
          0, 0, frame.image.width.toDouble(), frame.image.height.toDouble()),
      imageRect,
      Paint(),
    );

    // Rest of the text drawing code
    final textPainter = TextPainter(
      text: TextSpan(
        text: selectedSign,
        style: TextStyle(
          color: CupertinoColors.black,
          fontSize: 60,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2, imageRect.bottom + 40),
    );

    // Draw date range
    final dateRangePainter = TextPainter(
      text: TextSpan(
        text: getDateRange(selectedSign),
        style: TextStyle(
          color: CupertinoColors.black.withOpacity(0.5),
          fontSize: 30,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    dateRangePainter.paint(
      canvas,
      Offset((size.width - dateRangePainter.width) / 2, imageRect.bottom + 120),
    );

    // Draw summary text with paragraph
    final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontSize: 35,
      textAlign: TextAlign.center,
      height: 1.5,
    ))
      ..pushStyle(ui.TextStyle(
        color: CupertinoColors.black,
        height: 1.5,
      ))
      ..addText(summary);

    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: size.width - 80));

    canvas.drawParagraph(
      paragraph,
      Offset(40, imageRect.bottom + 200),
    );

    // Add logo image above watermark
    final ByteData logoData =
        await rootBundle.load('assets/icon/astro_buddy.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final logoCodec = await ui.instantiateImageCodec(logoBytes);
    final logoFrame = await logoCodec.getNextFrame();

    // Draw logo
    final logoSize = Size(35, 35);
    final logoRect = Rect.fromLTWH(
      (size.width - logoSize.width) / 2,
      size.height - 100, // Position above watermark
      logoSize.width,
      logoSize.height,
    );

    canvas.drawImageRect(
      logoFrame.image,
      Rect.fromLTWH(0, 0, logoFrame.image.width.toDouble(),
          logoFrame.image.height.toDouble()),
      logoRect,
      Paint()..color = CupertinoColors.white.withOpacity(0.5), // Add opacity
    );

    // Add watermark text
    final watermarkPainter = TextPainter(
      text: TextSpan(
        text: "Generated by Astro Buddy",
        style: TextStyle(
          color: CupertinoColors.systemGrey,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    watermarkPainter.paint(
      canvas,
      Offset((size.width - watermarkPainter.width) / 2, size.height - 50),
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> _shareStory(BuildContext context) async {
    final summary = await GeminiService.summarizeHoroscope(horoscopeText);
    final imageData = await _generateShareImage(context, summary);

    if (imageData != null) {
      // Create temporary file for sharing
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/horoscope.png').create();
      await file.writeAsBytes(imageData);

      // Share the file with MIME type
      final xFile = XFile(file.path, mimeType: 'image/png');
      await Share.shareXFiles([xFile],
          text: 'Check out my horoscope for Horoscope! 🌟');
    }
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
              // Add share button at the bottom
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: const Color(0xFF1f9a61),
                    onPressed: () => _shareStory(context),
                    child: Text(
                      'Share Horoscope',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                ),
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
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/signs/$selectedSign.png',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    selectedSign,
                    style: TextStyle(
                      color: textColor(context),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getDateRange(selectedSign),
                    style: TextStyle(
                      color: textColor(context).withOpacity(0.7),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Scrollable content in circular container
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
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
