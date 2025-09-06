import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_discomfort_when_exercise_service.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:corpofit_mobile/utils/widgets/custom_switch.dart';
import 'package:flutter/material.dart';

class DiscomfortWhenExercisingWidget extends StatefulWidget {
  const DiscomfortWhenExercisingWidget({super.key});

  @override
  State<DiscomfortWhenExercisingWidget> createState() =>
      _DiscomfortWhenExercisingWidgetState();
}

class _DiscomfortWhenExercisingWidgetState
    extends State<DiscomfortWhenExercisingWidget> {
  bool _isLoading = false;
  bool _experienceChestPainWhenExercise = false;
  bool _chestPainLastMonth = false;
  bool _dizzyOftenLostConsciousnessTooManyTimes = false;
  bool _takeMedicationForBloodPressureOrOtherCirculatoryProblems = false;
  bool _jointProblemsOrPainWorseExercise = false;
  bool _medicalAdviceWouldRecommendNotExerciseWithHighIntensity = false;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _experienceChestPainWhenExercise = false;
    _chestPainLastMonth = false;
    _dizzyOftenLostConsciousnessTooManyTimes = false;
    _takeMedicationForBloodPressureOrOtherCirculatoryProblems = false;
    _jointProblemsOrPainWorseExercise = false;
    _medicalAdviceWouldRecommendNotExerciseWithHighIntensity = false;
  }

  Future<void> _saveDiscomfortWhenExercise() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await LocalDiscomfortWhenExerciseService.save(
        'experience_chest_pain_when_exercise',
        _experienceChestPainWhenExercise,
      );
      await LocalDiscomfortWhenExerciseService.save(
        'chest_pain_last_month',
        _chestPainLastMonth,
      );
      await LocalDiscomfortWhenExerciseService.save(
        'dizzy_often_lost_consciousness_too_many_times',
        _dizzyOftenLostConsciousnessTooManyTimes,
      );

      await LocalDiscomfortWhenExerciseService.save(
        'take_medication_for_blood_pressure_or_other_circulatory_problems',
        _takeMedicationForBloodPressureOrOtherCirculatoryProblems,
      );

      await LocalDiscomfortWhenExerciseService.save(
        'joint_problems_or_pain_worse_exercise',
        _jointProblemsOrPainWorseExercise,
      );

      await LocalDiscomfortWhenExerciseService.save(
        'medicalAdviceWouldRecommendNotExerciseWithHighIntensity',
        _medicalAdviceWouldRecommendNotExerciseWithHighIntensity,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Información guardada correctamente')),
      );

      resetForm();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error saving discomfort when exercise: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving discomfort when exercise')),
      );
    }
  }

  Future<void> resetForm() async {
    setState(() {
      _experienceChestPainWhenExercise = false;
      _chestPainLastMonth = false;
      _dizzyOftenLostConsciousnessTooManyTimes = false;
      _takeMedicationForBloodPressureOrOtherCirculatoryProblems = false;
      _jointProblemsOrPainWorseExercise = false;
      _medicalAdviceWouldRecommendNotExerciseWithHighIntensity = false;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '¿Siente dolor en el pecho al realizar ejercicio?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomSwitch(
                value: _experienceChestPainWhenExercise,
                onChanged: (value) {
                  setState(() {
                    _experienceChestPainWhenExercise = value;
                  });
                },
                activeColor: Colors.deepPurple,
                inactiveThumbColor: Colors.grey,
                activeTrackColor: Colors.deepPurple.shade200,
                inactiveTrackColor: Colors.transparent,
                switchHeight: 25,
                switchWidth: 50,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                activeText: 'Sí',
                inactiveText: 'No',
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                '¿Ha tenido dolor en el pecho durante el último mes?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomSwitch(
                value: _chestPainLastMonth,
                onChanged: (value) {
                  setState(() {
                    _chestPainLastMonth = value;
                  });
                },
                activeColor: Colors.deepPurple,
                inactiveThumbColor: Colors.grey,
                activeTrackColor: Colors.deepPurple.shade200,
                inactiveTrackColor: Colors.transparent,
                switchHeight: 25,
                switchWidth: 50,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                activeText: 'Sí',
                inactiveText: 'No',
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                '¿Se marea frecuentemente o ha perdido el conocimiento demasiadas veces?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomSwitch(
                value: _dizzyOftenLostConsciousnessTooManyTimes,
                onChanged: (value) {
                  setState(() {
                    _dizzyOftenLostConsciousnessTooManyTimes = value;
                  });
                },
                activeColor: Colors.deepPurple,
                inactiveThumbColor: Colors.grey,
                activeTrackColor: Colors.deepPurple.shade200,
                inactiveTrackColor: Colors.transparent,
                switchHeight: 25,
                switchWidth: 50,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                activeText: 'Sí',
                inactiveText: 'No',
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                '¿Toma medicación para la presión arterial u otro problema circulatorio?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomSwitch(
                value:
                    _takeMedicationForBloodPressureOrOtherCirculatoryProblems,
                onChanged: (value) {
                  setState(() {
                    _takeMedicationForBloodPressureOrOtherCirculatoryProblems =
                        value;
                  });
                },
                activeColor: Colors.deepPurple,
                inactiveThumbColor: Colors.grey,
                activeTrackColor: Colors.deepPurple.shade200,
                inactiveTrackColor: Colors.transparent,
                switchHeight: 25,
                switchWidth: 50,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                activeText: 'Sí',
                inactiveText: 'No',
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                '¿Tiene problemas en las articulaciones o algún dolor que se agrava haciendo ejercicio?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomSwitch(
                value: _jointProblemsOrPainWorseExercise,
                onChanged: (value) {
                  setState(() {
                    _jointProblemsOrPainWorseExercise = value;
                  });
                },
                activeColor: Colors.deepPurple,
                inactiveThumbColor: Colors.grey,
                activeTrackColor: Colors.deepPurple.shade200,
                inactiveTrackColor: Colors.transparent,
                switchHeight: 25,
                switchWidth: 50,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                activeText: 'Sí',
                inactiveText: 'No',
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                '¿Cuenta con alguna otra recomendación médica que le recomiende no hacer realizar deporte con mucha intensidad?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomSwitch(
                value: _medicalAdviceWouldRecommendNotExerciseWithHighIntensity,
                onChanged: (value) {
                  setState(() {
                    _medicalAdviceWouldRecommendNotExerciseWithHighIntensity =
                        value;
                  });
                },
                activeColor: Colors.deepPurple,
                inactiveThumbColor: Colors.grey,
                activeTrackColor: Colors.deepPurple.shade200,
                inactiveTrackColor: Colors.transparent,
                switchHeight: 25,
                switchWidth: 50,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                activeText: 'Sí',
                inactiveText: 'No',
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        CustomButton(
          label: _isLoading ? 'Guardando...' : 'Guardar en local',
          buttonColor: _isLoading ? Colors.grey : Colors.blue,
          onPressed: () {
            if (_isLoading) return;
            _saveDiscomfortWhenExercise();
          },
        ),
      ],
    );
  }
}
