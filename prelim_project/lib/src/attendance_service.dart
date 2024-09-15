import 'models.dart';

class AttendanceService {
  final List<Student> _students = [];
  final List<AttendanceRecord> _records = [];

  void addStudent(Student student) {
    _students.add(student);
    print('Added student: ${student.name}');
  }

  void markAttendance(String studentId) {
    final student = _students.firstWhere(
      (s) => s.id == studentId,
      orElse: () => throw Exception('Student not found'),
    );
    final record = AttendanceRecord(
      studentId: student.id,
      timestamp: DateTime.now(),
      present: true,
    );
    _records.add(record);
    print('Marked attendance for: ${student.name}');
  }

  void listAttendance() {
    if (_records.isEmpty) {
      print('No attendance records found.');
      return;
    }
    for (var record in _records) {
      final student = _students.firstWhere((s) => s.id == record.studentId);
      print(
          'Student: ${student.name}, Time: ${record.timestamp}, Present: ${record.present}');
    }
  }

  void listStudents() {
    if (_students.isEmpty) {
      print('No students found.');
      return;
    }
    for (var student in _students) {
      print('ID: ${student.id}, Name: ${student.name}');
    }
  }
}
