class Attendance {
  final String studentId;
  final String studentName;
  final DateTime time;

  Attendance({
    required this.studentId,
    required this.studentName,
    required this.time,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      studentId: json['studentId'],
      studentName: json['studentName'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'time': time.toIso8601String(),
    };
  }
}
