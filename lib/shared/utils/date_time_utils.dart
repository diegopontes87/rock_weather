abstract class DateTimeUtils {
  static bool isDateToday(int milliseconds) {
    DateTime dateToCheck = DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
    DateTime today = DateTime.now();
    return dateToCheck.year == today.year && dateToCheck.month == today.month && dateToCheck.day == today.day;
  }

  static DateTime getDateDay(int milliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
    DateTime day = DateTime(date.year, date.month, date.day);
    return day;
  }

  static String getHour(int milliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
    return '${date.hour}h:00m';
  }

  static String formatDateAbbreviated(int milliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
    List<String> monthNames = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    int day = date.day;
    int monthIndex = date.month;
    int hour = date.hour;
    String formattedDate = '$day, ${monthNames[monthIndex]}\n${hour}h:00m';
    return formattedDate;
  }
}
