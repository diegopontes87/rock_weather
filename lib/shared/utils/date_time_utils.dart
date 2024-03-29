import 'package:intl/intl.dart';

abstract class DateTimeUtils {
  static String millisecondsToDate(int milliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  static bool isDateToday(int milliseconds) {
    DateTime dateToCheck = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    DateTime today = DateTime.now();
    return dateToCheck.year == today.year && dateToCheck.month == today.month && dateToCheck.day == today.day;
  }
}
