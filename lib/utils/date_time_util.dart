import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get fullDate => DateFormat('EEEE, MMMM dd').format(this);
}
