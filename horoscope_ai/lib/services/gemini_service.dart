import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static GenerativeModel? _model;

  static void initialize() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY not found in environment variables');
    }

    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
  }

  static Future<String> getHoroscopeReading(String sign) async {
    if (_model == null) {
      initialize();
    }

    try {
      final prompt = '''
        Your are a fortune teller, generate a personalized horoscope reading for $sign.
        Include:
        - Main prediction
        - Furtune Teller's advice
        - Lucky numbers
        - Lucky colors
        - Key advice
        - Love advice
        - Career advice
        - Health advice
        - Life advice
        Format the response in clear sections.
      ''';

      final response = await _model!.generateContent([
        Content.text(prompt),
      ]);

      if (response.text == null || response.text!.isEmpty) {
        return 'Unable to generate reading. Please try again.';
      }

      return response.text!;
    } catch (e) {
      return 'Error: Unable to generate horoscope. Please check your internet connection and try again.';
    }
  }

  static Future<String> summarizeHoroscope(String horoscopeText) async {
    if (_model == null) {
      initialize();
    }

    try {
      final prompt = '''
        Summarize the key points from this horoscope reading in 250 Characters. 
        Make it 250 characters total:
        $horoscopeText
      ''';

      final response = await _model!.generateContent([
        Content.text(prompt),
      ]);

      if (response.text == null || response.text!.isEmpty) {
        return 'Your stars align for positive changes. Focus on personal growth today. Trust your instincts moving forward.';
      }

      // Ensure we don't exceed length constraints
      String summary = response.text!;
      if (summary.length > 250) {
        summary = '${summary.substring(0, 243)}...';
      }

      return summary;
    } catch (e) {
      // Return a generic summary if generation fails
      return 'The stars suggest positive opportunities ahead. Take time to reflect on your goals. Trust your inner wisdom to guide you forward.';
    }
  }
}
