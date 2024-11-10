import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:horoscope_ai/config/app_config.dart';

class GeminiService {
  static final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: AppConfig.geminiApiKey,
  );

  static Future<String> getHoroscopeReading(String sign) async {
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

      final response = await _model.generateContent([
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
}
