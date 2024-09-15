import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'package:prelim_project/providers.dart';
import 'package:prelim_project/src/models.dart';
import 'package:prelim_project/src/attendance_service.dart';

void main() {
  final container = ProviderContainer();
  final attendanceService = container.read(attendanceServiceProvider);

  while (true) {
    print('\nAttendance System');
    print('1. Add Student');
    print('2. Mark Attendance');
    print('3. List Students');
    print('4. List Attendance Records');
    print('5. Exit');
    stdout.write('Choose an option: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        _addStudent(attendanceService);
        break;
      case '2':
        _markAttendance(attendanceService);
        break;
      case '3':
        attendanceService.listStudents();
        break;
      case '4':
        attendanceService.listAttendance();
        break;
      case '5':
        print('Exiting...');
        exit(0);
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void _addStudent(AttendanceService service) {
  stdout.write('Enter student ID: ');
  final id = stdin.readLineSync();
  stdout.write('Enter student name: ');
  final name = stdin.readLineSync();

  if (id == null || name == null || id.isEmpty || name.isEmpty) {
    print('Invalid input. Student not added.');
    return;
  }

  final student = Student(id: id, name: name);
  service.addStudent(student);
}

void _markAttendance(AttendanceService service) {
  stdout.write('Enter student ID to mark attendance: ');
  final id = stdin.readLineSync();

  if (id == null || id.isEmpty) {
    print('Invalid input.');
    return;
  }

  try {
    service.markAttendance(id);
  } catch (e) {
    print(e);
  }
}
