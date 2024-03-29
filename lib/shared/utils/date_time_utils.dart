abstract class DateTimeUtils {
  static bool isDateToday(int milliseconds) {
    DateTime dateToCheck = DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
    DateTime today = DateTime.now();
    return dateToCheck.year == today.year && dateToCheck.month == today.month && dateToCheck.day == today.day;
  }
}
