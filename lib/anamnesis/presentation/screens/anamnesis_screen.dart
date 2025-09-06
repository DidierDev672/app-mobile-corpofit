import 'package:corpofit_mobile/anamnesis/presentation/widgets/Summary_of_anamnesis_widget.dart';
import 'package:corpofit_mobile/anamnesis/presentation/widgets/basic_anamnesis_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class AnamnesisScreen extends StatefulWidget {
  const AnamnesisScreen({Key? key}) : super(key: key);

  @override
  State<AnamnesisScreen> createState() => _AnamnesisScreenState();
}

class _AnamnesisScreenState extends State<AnamnesisScreen> {
  int currentStep = 0;

  List<Step> mySteps = [
    Step(
      title: const Text('Datos Basicos'),
      content: const BasicAnamnesisDataWidget(),
    ),
    Step(
      title: const Text('Medicamentos'),
      content: const MedicationUseWidget(),
    ),
    Step(
      title: const Text('Dolor al Ejercitarse'),
      content: const DiscomfortWhenExercisingWidget(),
    ),
    Step(
      title: const Text('Resumen'),
      content: const SummaryOfAnamnesisWidget(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anamnesis'),
        leading: InkWell(
          onTap: () {
            context.go('/');
          },

          child: Container(
            padding: EdgeInsets.all(10),
            child: const Icon(Icons.arrow_back, size: 20),
          ),
        ),
      ),
      body: Stepper(
        currentStep: currentStep,
        steps: mySteps,
        type: StepperType.vertical,
        onStepTapped: (step) {
          setState(() {
            currentStep = step;
          });
        },

        onStepCancel: () {
          setState(() {
            if (currentStep > 0) {
              currentStep = currentStep - 1;
            } else {
              currentStep = 0;
            }
          });
        },

        onStepContinue: () {
          setState(() {
            if (currentStep < mySteps.length - 1) {
              currentStep = currentStep + 1;
            } else {
              currentStep = 0;
            }
          });
        },
      ),
    );
  }
}
