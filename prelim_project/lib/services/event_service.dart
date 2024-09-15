import 'package:prelim_project/models/event.dart';
import 'package:prelim_project/utils/json_handler.dart';

class EventService {
  final JsonHandler jsonHandler;

  EventService(this.jsonHandler);

  Future<void> addEvent(Event event) async {
    final events = await jsonHandler.readJson();
    events.add(event.toJson());
    await jsonHandler.writeJson(events);
  }

  Future<List<Event>> getEvents() async {
    final events = await jsonHandler.readJson();
    return events.map((e) => Event.fromJson(e)).toList();
  }
}