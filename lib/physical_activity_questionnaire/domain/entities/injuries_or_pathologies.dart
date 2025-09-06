class InjuriesOrPathologies {
  final bool beenInjured;
  final String? indicateInjuryOne;
  final String? longAgoOne;
  final bool treatedMedically;
  final String? indicateInjuryTwo;
  final String? longAgoTwo;
  final String? preventsFromDoing;
  final bool physicalPainOrDiscomfort;
  final String? indicateInjuryThree;
  final String? longAgoThree;
  final bool? havePathologies;
  final bool? tratedMedically;

  InjuriesOrPathologies({
    required this.beenInjured,
    this.indicateInjuryOne,
    this.longAgoOne,
    required this.treatedMedically,
    this.indicateInjuryTwo,
    this.longAgoTwo,
    this.preventsFromDoing,
    required this.physicalPainOrDiscomfort,
    this.indicateInjuryThree,
    this.longAgoThree,
    this.havePathologies,
    this.tratedMedically,
  });
}
