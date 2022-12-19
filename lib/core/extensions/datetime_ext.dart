extension DateTimeExt on DateTime {
  String get format {
    final d = this;
    String hour = d.hour.toString();
    if (hour.length == 1) hour = '0$hour';
    String min = d.minute.toString();
    if (min.length == 1) min = '0$min';
    return '${d.day}/${d.month}/${d.year}-$hour:$min';
  }
}
