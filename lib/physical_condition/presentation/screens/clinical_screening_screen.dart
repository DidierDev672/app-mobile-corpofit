import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:corpofit_mobile/utils/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../infrastructure/infrastructure.dart';

class ClinicalScreeningScreen extends StatefulWidget {
  const ClinicalScreeningScreen({super.key});

  @override
  State<ClinicalScreeningScreen> createState() =>
      _ClinicalScreeningScreenState();
}

class _ClinicalScreeningScreenState extends State<ClinicalScreeningScreen> {
  String _resultMValue = 'md/dl';
  String _clasificationValue = 'Normal';
  List<String> resultM = ['md/dl', 'mg/dl'];
  List<String> clasification = ['Normal', 'Pre-diabetes', 'Diabetes'];

  final activityController = TextEditingController();
  final resultController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyData();
    });
  }

  Future<void> _saveData() async {
    try {
      await LocalClinicalScreeningService.save(
        'activity',
        activityController.text,
      );
      await LocalClinicalScreeningService.save('result', resultController.text);
      await LocalClinicalScreeningService.save('resultEnum', _resultMValue);
      await LocalClinicalScreeningService.save(
        'classification',
        _clasificationValue,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tamizaje clínico guardado exitosamente')),
      );

      if (mounted) {
        context.go('/summary_clinical_screening');
      }
    } catch (e) {
      debugPrint("Error guardando datos: $e");
    }
  }

  Future<void> _verifyData() async {
    String activity = LocalClinicalScreeningService.read('activity') ?? '';
    if (!activity.isNotEmpty || activity != '') {
      if (mounted) {
        context.go('/summary_clinical_screening');
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tamizaje Clínico',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        leading: InkWell(
          onTap: () {
            context.go('/physical_condition');
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.arrow_back, size: 20),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Indicador',
                    style: textStyle.titleLarge?.copyWith(
                      fontSize: size.width * 0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              CustomInput(
                label: 'Actividad física',
                hint: 'Caminata de 6 minutos',
                onChanged: (value) => activityController.text = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa el resultado';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Resultado',
                      style: textStyle.titleMedium?.copyWith(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Text(
                      'Calificación',
                      style: textStyle.titleMedium?.copyWith(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomInput(
                      label: 'Resultado',
                      hint: 'Ingrese el resultado',
                      onChanged: (value) => resultController.text = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa el resultado';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButton<String>(
                        value: _resultMValue,
                        isExpanded: true,
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(15),
                        hint: Text(
                          'Resultado',
                          style: textStyle.titleMedium?.copyWith(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        items:
                            resultM
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _resultMValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButton<String>(
                        value: _clasificationValue,
                        isExpanded: true,
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(15),
                        hint: Text(
                          'Calificación',
                          style: textStyle.titleMedium?.copyWith(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        items:
                            clasification
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _clasificationValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: 250,
                height: 75,
                child: CustomButton(
                  label: 'Guardar',
                  buttonColor: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: _saveData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
