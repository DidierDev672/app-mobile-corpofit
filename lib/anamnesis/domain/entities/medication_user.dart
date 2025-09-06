class MedicationUser {
  final bool frequentlyTakenMedications;
  final String? nameOfMedication;
  final DateTime lastMedicalCheckUp;
  final bool? remember;
  final bool motherOrFatherAnyIllnes;
  final String? nameOfIllnes;
  final bool smoke;
  final bool qarP;

  const MedicationUser({
    required this.frequentlyTakenMedications,
    this.nameOfMedication,
    required this.lastMedicalCheckUp,
    this.remember,
    required this.motherOrFatherAnyIllnes,
    this.nameOfIllnes,
    required this.smoke,
    required this.qarP,
  });
}
