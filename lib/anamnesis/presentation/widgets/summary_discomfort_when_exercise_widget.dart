import 'package:corpofit_mobile/anamnesis/domain/domain.dart';
import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_discomfort_when_exercise_service.dart';
import 'package:flutter/material.dart';

class SummaryDiscomfortWhenExerciseWidget extends StatefulWidget {
  const SummaryDiscomfortWhenExerciseWidget({super.key});

  @override
  State<SummaryDiscomfortWhenExerciseWidget> createState() =>
      _SummaryDiscomfortWhenExerciseWidgetState();
}

class _SummaryDiscomfortWhenExerciseWidgetState
    extends State<SummaryDiscomfortWhenExerciseWidget> {
  DiscomfortWhenExercise? _discomfortWhenExercise;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _loadDiscomfortWhenExercise();
  }

  Future<void> _loadDiscomfortWhenExercise() async {
    setState(() {
      _isLoading = true;
      _discomfortWhenExercise = DiscomfortWhenExercise(
        experienceChestPainWhenExercise:
            LocalDiscomfortWhenExerciseService.read(
              'experience_chest_pain_when_exercise',
            ) ??
            false,
        chestPainLastMonth:
            LocalDiscomfortWhenExerciseService.read('chest_pain_last_month') ??
            false,
        dizzyOftenLostConsciousnessTooManyTimes:
            LocalDiscomfortWhenExerciseService.read(
              'dizzy_often_lost_consciousness_too_many_times',
            ) ??
            false,
        takeMedicationForBloodPressureOrOtherCirculatoryProblems:
            LocalDiscomfortWhenExerciseService.read(
              'take_medication_for_blood_pressure_or_other_circulatory_problems',
            ) ??
            false,
        jointProblemsOrPainWorseExercise:
            LocalDiscomfortWhenExerciseService.read(
              'joint_problems_or_pain_worse_exercise',
            ) ??
            false,
        medicalAdviceWouldRecommendNotExerciseWithHighIntensity:
            LocalDiscomfortWhenExerciseService.read(
              'medicalAdviceWouldRecommendNotExerciseWithHighIntensity',
            ) ??
            false,
      );
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_discomfortWhenExercise == null) {
      return Center(child: Text('No hay datos', style: textStyle.titleMedium));
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
      child: DiscomfortWhenExerciseSummaryCard(
        discomfortWhenExercise: _discomfortWhenExercise!,
      ),
    );
  }
}

class DiscomfortWhenExerciseSummaryCard extends StatelessWidget {
  final DiscomfortWhenExercise discomfortWhenExercise;
  const DiscomfortWhenExerciseSummaryCard({
    super.key,
    required this.discomfortWhenExercise,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          'Resumen de molestias al ejercicio',
          style: textTheme.titleMedium?.copyWith(fontSize: size.width * 0.05),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.warning_amber,
            size: 34,
            color:
                discomfortWhenExercise.experienceChestPainWhenExercise
                    ? Colors.deepPurple
                    : Colors.grey,
          ),
          title: Text(
            discomfortWhenExercise.experienceChestPainWhenExercise
                ? 'Si'
                : 'No',
            style: textTheme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Siente dolor en el pecho al hace ejercicio?',
            style: textTheme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        Divider(
          color:
              discomfortWhenExercise.experienceChestPainWhenExercise
                  ? Colors.deepPurple
                  : Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.waving_hand_rounded,
            size: 34,
            color:
                discomfortWhenExercise.chestPainLastMonth
                    ? Colors.deepPurple
                    : Colors.grey,
          ),
          title: Text(
            discomfortWhenExercise.chestPainLastMonth ? 'Si' : 'No',
            style: textTheme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Ha tenido dolor en el pecho durante el último mes?',
            style: textTheme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        Divider(
          color:
              discomfortWhenExercise.chestPainLastMonth
                  ? Colors.purple
                  : Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.sports_bar,
            size: 34,
            color:
                discomfortWhenExercise.dizzyOftenLostConsciousnessTooManyTimes
                    ? Colors.purple
                    : Colors.grey,
          ),
          title: Text(
            discomfortWhenExercise.dizzyOftenLostConsciousnessTooManyTimes
                ? 'Si'
                : 'No',
            style: textTheme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Se marea frecuentemente o ha perdido el conocimiento demasiadas veces?',
            style: textTheme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        Divider(
          color:
              discomfortWhenExercise.dizzyOftenLostConsciousnessTooManyTimes
                  ? Colors.purple
                  : Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.heart_broken_rounded,
            size: 34,
            color:
                discomfortWhenExercise
                        .takeMedicationForBloodPressureOrOtherCirculatoryProblems
                    ? Colors.purpleAccent
                    : Colors.grey,
          ),
          title: Text(
            discomfortWhenExercise
                    .takeMedicationForBloodPressureOrOtherCirculatoryProblems
                ? 'Si'
                : 'No',
            style: textTheme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Toma medicación para la presión arterial u otro problema circulatorio?',
            style: textTheme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        Divider(
          color:
              discomfortWhenExercise
                      .takeMedicationForBloodPressureOrOtherCirculatoryProblems
                  ? Colors.purpleAccent
                  : Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.personal_injury_outlined,
            size: 34,
            color:
                discomfortWhenExercise.jointProblemsOrPainWorseExercise
                    ? Colors.purpleAccent
                    : Colors.grey,
          ),
          title: Text(
            discomfortWhenExercise.jointProblemsOrPainWorseExercise
                ? 'Si'
                : 'No',
            style: textTheme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Tiene problemas en las articulaciones o algún dolor que se agrava realizando ejercicos ?',
            style: textTheme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
        Divider(
          color:
              discomfortWhenExercise.jointProblemsOrPainWorseExercise
                  ? Colors.purple
                  : Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.health_and_safety,
            size: 34,
            color:
                discomfortWhenExercise
                        .medicalAdviceWouldRecommendNotExerciseWithHighIntensity
                    ? Colors.purpleAccent
                    : Colors.grey,
          ),
          title: Text(
            discomfortWhenExercise
                    .medicalAdviceWouldRecommendNotExerciseWithHighIntensity
                ? 'Si'
                : 'No',
            style: textTheme.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Cuenta con alguna otra recomendación médica que le recomiende no realizar deporte con mucha intensidad?',
            style: textTheme.titleSmall?.copyWith(fontSize: size.width * 0.04),
          ),
        ),
      ],
    );
  }
}
