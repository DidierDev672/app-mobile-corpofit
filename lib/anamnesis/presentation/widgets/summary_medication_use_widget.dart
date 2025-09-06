import 'package:corpofit_mobile/anamnesis/domain/domain.dart';
import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_medication_user_service.dart';
import 'package:flutter/material.dart';

class SummaryMedicationUseWidget extends StatefulWidget {
  const SummaryMedicationUseWidget({super.key});

  @override
  State<SummaryMedicationUseWidget> createState() =>
      _SummaryMedicationUseWidgetState();
}

class _SummaryMedicationUseWidgetState
    extends State<SummaryMedicationUseWidget> {
  bool _isLoading = false;
  MedicationUser? medicationUser;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    try {
      setState(() {
        _isLoading = true;

        medicationUser = MedicationUser(
          frequentlyTakenMedications:
              LocalMedicationUserService.read<bool>(
                'frequently_taken_medications',
              )!,
          nameOfMedication:
              LocalMedicationUserService.read<String>('name_of_medication')!,
          nameOfIllnes: LocalMedicationUserService.read<String>(
            'name_of_illnes',
          ),
          lastMedicalCheckUp: DateTime.parse(
            LocalMedicationUserService.read<String>("last_medical_check_up") ??
                DateTime.now().toString(),
          ),
          remember: LocalMedicationUserService.read<bool>('remember')!,
          motherOrFatherAnyIllnes:
              LocalMedicationUserService.read<bool>(
                'mother_or_father_any_illnes',
              )!,
          smoke: LocalMedicationUserService.read<bool>('smoke')!,
          qarP: LocalMedicationUserService.read<bool>('qar_p')!,
        );
      });
    } catch (e) {
      debugPrint('Error al inicializar Hive: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (medicationUser == null) {
      return Center(
        child: Text(
          'No hay datos disponibles',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(15),
          topRight: Radius.circular(25),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 10),
      child: MedicationUserSummaryCard(medicationUser: medicationUser!),
    );
  }
}

class MedicationUserSummaryCard extends StatelessWidget {
  final MedicationUser medicationUser;
  const MedicationUserSummaryCard({super.key, required this.medicationUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Medicación frecuente',
          style: theme.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(
            Icons.medication_liquid,
            size: 34,
            color:
                medicationUser.frequentlyTakenMedications
                    ? Colors.green
                    : Colors.grey,
          ),
          title: Text(
            medicationUser.frequentlyTakenMedications ? 'Si' : 'No',
            style: theme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Consume algún medicamento frecuentemente?',
            style: theme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        if (medicationUser.frequentlyTakenMedications) ...{
          ListTile(
            leading: Icon(
              Icons.medication_outlined,
              size: 34,
              color:
                  medicationUser.frequentlyTakenMedications
                      ? Colors.deepPurple
                      : Colors.grey,
            ),
            title: Text(
              medicationUser.nameOfMedication!,
              style: theme.titleMedium?.copyWith(fontSize: size.width * 0.05),
            ),
          ),
        },
        Divider(
          color:
              medicationUser.frequentlyTakenMedications
                  ? Colors.green
                  : Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.date_range_outlined,
            size: 34,
            color: Colors.blueAccent,
          ),
          title: Text(
            medicationUser.lastMedicalCheckUp.toString(),
            style: theme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Cúando fue su último control médico?',
            style: theme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        if (medicationUser.lastMedicalCheckUp != null ||
            medicationUser.lastMedicalCheckUp != false) ...{
          ListTile(
            leading: Icon(
              Icons.breakfast_dining,
              size: 34,
              color: Colors.blueAccent,
            ),
            title: Text(
              medicationUser.remember! ? '' : 'No recuerda',
              style: theme.titleMedium?.copyWith(fontSize: size.width * 0.05),
            ),
            subtitle: Text(
              '¿Cúando fue su último control médico?',
              style: theme.titleSmall?.copyWith(fontSize: size.width * 0.04),
            ),
          ),
        },
        Divider(
          color:
              medicationUser.lastMedicalCheckUp != false
                  ? Colors.blue
                  : Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.personal_injury,
            size: 34,
            color:
                medicationUser.motherOrFatherAnyIllnes
                    ? Colors.green
                    : Colors.grey,
          ),
          title: Text(
            medicationUser.motherOrFatherAnyIllnes ? 'Si' : 'No',
            style: theme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Su madre o padre tiene algún enfermedad?',
            style: theme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        if (medicationUser.motherOrFatherAnyIllnes) ...{
          ListTile(
            leading: Icon(
              Icons.personal_injury_rounded,
              size: 34,
              color:
                  medicationUser.motherOrFatherAnyIllnes
                      ? Colors.deepPurple
                      : Colors.grey,
            ),
            title: Text(
              medicationUser.nameOfIllnes!,
              style: theme.titleMedium?.copyWith(fontSize: size.width * 0.05),
            ),
          ),
        },
        Divider(
          color:
              medicationUser.motherOrFatherAnyIllnes
                  ? Colors.green
                  : Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.smoking_rooms_outlined,
            size: 34,
            color: medicationUser.smoke ? Colors.blueAccent : Colors.grey,
          ),
          title: Text(
            medicationUser.smoke ? 'Si' : 'No',
            style: theme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Fuma?',
            style: theme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        Divider(color: medicationUser.smoke ? Colors.blue : Colors.grey),

        ListTile(
          leading: Icon(
            Icons.heart_broken_outlined,
            size: 34,
            color: medicationUser.qarP ? Colors.redAccent : Colors.grey,
          ),
          title: Text(
            medicationUser.qarP ? 'Si' : 'No',
            style: theme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Alguna vez le ha diagnosticado su médico un problema en el corazón, recomendándole que solo haga deporte bajo supervisión médica?',
            style: theme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
      ],
    );
  }
}
