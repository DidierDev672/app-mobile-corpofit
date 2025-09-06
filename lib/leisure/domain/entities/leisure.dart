class Leisure {
  final String activity;
  final String manyDaysWeek;
  final String timePerDay;
  final String sleepHours;
  final String sleepMinutes;
  final TimeFormat formatSleep;
  final String recoveredOrRested;
  final String timeToGetUp;
  final String minutesAfterGettingUp;
  final TimeFormat formatTimeToGetUp;
  final String bedtime;
  final String minuteToSleep;
  final TimeFormat formatBedtime;

  Leisure({
    required this.activity,
    required this.manyDaysWeek,
    required this.timePerDay,
    required this.sleepHours,
    required this.sleepMinutes,
    required this.formatSleep,
    required this.recoveredOrRested,
    required this.timeToGetUp,
    required this.minutesAfterGettingUp,
    required this.formatTimeToGetUp,
    required this.bedtime,
    required this.minuteToSleep,
    required this.formatBedtime,
  });
}

enum TimeFormat { AM, PM }
