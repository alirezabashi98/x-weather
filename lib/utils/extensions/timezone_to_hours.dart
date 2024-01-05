import 'package:intl/intl.dart';

extension TimezoneToHours on int? {
  String convertTimezoneToHours() {
    if (this == null) return '';

    // تبدیل timezone Shift از ثانیه به Duration
    Duration duration = Duration(seconds: this!);

    // گرفتن زمان گرینویچ
    DateTime utcDateTime = DateTime.now().toUtc();

    // جمع زدن ساعت گرینویچ با شیفت تایم زون
    DateTime localDateTime = utcDateTime.add(duration);
    String formattedLocalTime = DateFormat('HH:mm').format(localDateTime);

    return formattedLocalTime;
  }

  // تابع برای تبدیل Duration به ساعت و دقیقه
  String formatDurationToTime(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60).abs();

    // فرمت کردن ساعت و دقیقه به صورت HH:mm
    String formattedTime =
        DateFormat('HH:mm').format(DateTime(0, 1, 1, hours, minutes));

    return formattedTime;
  }
}
