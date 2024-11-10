import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horoscope_ai/services/gemini_service.dart';

// State for selected sign
final selectedSignProvider = StateProvider<String>((ref) => '');

// State for loading status
final isLoadingProvider = StateProvider<bool>((ref) => false);

// State for horoscope text
final horoscopeTextProvider = StateProvider<String>((ref) => '');

// Function to generate horoscope
final generateHoroscopeProvider = FutureProvider<void>((ref) async {
  final selectedSign = ref.watch(selectedSignProvider);

  if (selectedSign.isEmpty) {
    return;
  }

  ref.read(isLoadingProvider.notifier).state = true;

  try {
    final horoscope = await GeminiService.getHoroscopeReading(selectedSign);
    ref.read(horoscopeTextProvider.notifier).state = horoscope;
  } catch (e) {
    ref.read(horoscopeTextProvider.notifier).state =
        'Error generating horoscope: $e';
  } finally {
    ref.read(isLoadingProvider.notifier).state = false;
  }
});
