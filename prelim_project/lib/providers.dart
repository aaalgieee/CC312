import 'package:riverpod/riverpod.dart';
import 'package:prelim_project/services/event_service.dart';
import 'package:prelim_project/utils/json_handler.dart'; // Import the necessary file

final jsonHandlerProvider = Provider((ref) => JsonHandler()); // Define the provider

final eventServiceProvider =
    Provider((ref) => EventService(ref.watch(jsonHandlerProvider)));
