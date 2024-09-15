class Student {
  final String id;
  final String name;

  Student({required this.id, required this.name});
}

class AttendanceRecord {
  final String studentId;
  final DateTime timestamp;
  bool present;

  AttendanceRecord({
    required this.studentId,
    required this.timestamp,
    this.present = true,
  });
}
