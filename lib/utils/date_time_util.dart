import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatCurrentDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMMM dd').format(now).toUpperCase();
  }
}
