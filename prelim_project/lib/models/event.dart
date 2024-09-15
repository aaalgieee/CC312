import 'attendance.dart'; // Add this line

class Event {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final List<Attendance> attendanceRecords;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    List<Attendance>? attendanceRecords,
  }) : attendanceRecords = attendanceRecords ?? [];

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      attendanceRecords: (json['attendanceRecords'] as List)
          .map((e) => Attendance.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'location': location,
      'attendanceRecords': attendanceRecords.map((e) => e.toJson()).toList(),
    };
  }
}
