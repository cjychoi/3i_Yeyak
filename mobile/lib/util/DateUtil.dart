extension DateUtil on DateTime {
  DateTime copyWith(
      {int? year,
      int? month,
      int? day,
      int? hour,
      int? minute,
      int? second,
      int? millisecond,
      int? microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime roundWithin30Minutes() {
    final int deltaMinute;
    if (this.minute < 15) {
      deltaMinute = -this.minute; // go back to zero
    } else if (this.minute < 45) {
      deltaMinute = 30 - this.minute; // go to 30 minutes
    } else {
      deltaMinute = 60 - this.minute;
    }
    return this.add(Duration(
        milliseconds: -this.millisecond,
        // reset milliseconds to zero
        microseconds: -this.microsecond,
        // reset microseconds to zero,
        seconds: -this.second,
        // reset seconds to zero
        minutes: deltaMinute));
  }
}
