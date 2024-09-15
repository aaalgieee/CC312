import 'package:riverpod/riverpod.dart';
import 'src/attendance_service.dart';

// Provider for AttendanceService
final attendanceServiceProvider = Provider<AttendanceService>((ref) {
  return AttendanceService();
});
