class ActivityWork {
  final String doForWork;
  final String hoursSpendWorking;
  final String averageHourSitting;
  final String averageStandingHours;
  final bool activityRepresentPainDiscomfort;
  final String? which;

  ActivityWork({
    required this.doForWork,
    required this.hoursSpendWorking,
    required this.averageHourSitting,
    required this.averageStandingHours,
    required this.activityRepresentPainDiscomfort,
    this.which,
  });
}
