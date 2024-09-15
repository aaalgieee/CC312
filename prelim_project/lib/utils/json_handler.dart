import 'dart:io';
import 'dart:convert';

class JsonHandler {
  Future<List<dynamic>> readJson() async {
    final file = File('data/events.json');
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString('[]');
    }
    final fileContent = await file.readAsString();
    if (fileContent.trim().isEmpty) {
      return [];
    }
    return jsonDecode(fileContent);
  }

  Future<void> writeJson(List<dynamic> data) async {
    final json = jsonEncode(data);
    await File('data/events.json').writeAsString(json);
  }
}
