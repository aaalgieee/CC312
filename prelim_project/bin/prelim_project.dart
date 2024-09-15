import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'package:prelim_project/models/event.dart';
import 'package:prelim_project/models/attendance.dart';
import 'package:prelim_project/providers.dart';
import 'package:uuid/uuid.dart';

void main() async {
  final container = ProviderContainer();
  final eventService = container.read(eventServiceProvider);

  print('Enter event name:');
  final name = stdin.readLineSync()!;

  print('Enter event date (YYYY-MM-DD):');
  final dateInput = stdin.readLineSync();
  final date = DateTime.parse(dateInput!);

  print('Enter event location:');
  final location = stdin.readLineSync()!;

  final event = Event(
    id: Uuid().v4(), // Generate a UUID for the id
    name: name,
    date: date,
    location: location,
  );

  //await eventService.addEvent(event);

  while (true) {
    print('Enter student ID (or type "exit" to finish):');
    final studentId = stdin.readLineSync();
    if (studentId == 'exit') break;

    print('Enter student name:');
    final studentName = stdin.readLineSync()!;

    final attendance = Attendance(
      studentId: studentId!,
      studentName: studentName,
      time: DateTime.now(),
    );

    event.attendanceRecords.add(attendance);
  }

  await eventService.addEvent(event);
  print('Event and attendance records saved successfully.');
}
