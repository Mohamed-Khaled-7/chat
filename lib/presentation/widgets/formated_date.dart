
import 'package:intl/intl.dart';

String formatTime(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return DateFormat('hh:mm a').format(parsedDate);
}