import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:corpofit_mobile/utils/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../infrastructure/infrastructure.dart';

class PhysicalExerciseScreen extends StatefulWidget {
  const PhysicalExerciseScreen({super.key});

  @override
  State<PhysicalExerciseScreen> createState() => _PhysicalExerciseScreenState();
}

class _PhysicalExerciseScreenState extends State<PhysicalExerciseScreen> {
  bool? _isExercise;
  bool? _notExercise;
  bool? _neverExercise;

  String? _whatActivity;
  String? _yearsNotTrained;
  String? _monthsNotTrained;
  String? _yearsNotBeenTraining;
  String? _monthsNotBeenTraining;
  String? _whatIntentionCarryPractice;
  String? _preventedHimFromContinuingPractice;
  String? _motivatesStartExercising;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyExisting();
    });
  }

  Future<void> _saveData() async {
    await LocalPhysicalExercise.save('isExercise', _isExercise);
    await LocalPhysicalExercise.save('notExercise', _notExercise);
    await LocalPhysicalExercise.save('neverExercise', _neverExercise);
    await LocalPhysicalExercise.save('whatActivity', _whatActivity);
    await LocalPhysicalExercise.save('yearsNotTrained', _yearsNotTrained);
    await LocalPhysicalExercise.save('monthsNotTrained', _monthsNotTrained);
    await LocalPhysicalExercise.save(
      'yearsNotBeenTraining',
      _yearsNotBeenTraining,
    );
    await LocalPhysicalExercise.save(
      'monthsNotBeenTraining',
      _monthsNotBeenTraining,
    );
    await LocalPhysicalExercise.save(
      'whatIntentionCarryPractice',
      _whatIntentionCarryPractice,
    );
    await LocalPhysicalExercise.save(
      'preventedHimFromContinuingPractice',
      _preventedHimFromContinuingPractice,
    );
    await LocalPhysicalExercise.save(
      'motivatesStartExercising',
      _motivatesStartExercising,
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos guardados correctamente')),
      );
      context.go('/summary_physical_exercise');
    }
  }

  Future<void> _verifyExisting() async {
    final existingData = LocalPhysicalExercise.read<bool>('isExercise');
    final existingData2 = LocalPhysicalExercise.read<bool>('notExercise');
    final existingData3 = LocalPhysicalExercise.read<bool>('neverExercise');
    if (existingData != null ||
        existingData2 != null ||
        existingData3 != null) {
      context.go('/summary_physical_exercise');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isExercise = null;
    _notExercise = null;
    _neverExercise = null;
    _whatActivity = null;
    _yearsNotTrained = null;
    _monthsNotTrained = null;
    _yearsNotBeenTraining = null;
    _monthsNotBeenTraining = null;
    _whatIntentionCarryPractice = null;
    _preventedHimFromContinuingPractice = null;
    _motivatesStartExercising = null;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio físico', style: textStyle.titleLarge),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
            size: 35,
          ),
          onPressed: () {
            context.go('/physical_activity_questionnaire');
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
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
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 16),
              Text(
                '¿Realiza o ha realizado ejercico físico?',
                style: textStyle.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: RadioListTile(
                  activeColor: Colors.blueAccent,
                  value: true,
                  groupValue: _isExercise,
                  onChanged: (value) {
                    setState(() {
                      _isExercise = value;
                      _notExercise = false;
                      _neverExercise = false;
                    });
                  },
                  title: Text(
                    'Actualmente hago ejercicio',
                    style: textStyle.titleMedium,
                  ),
                ),
              ),
              SizedBox(height: 16),
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: RadioListTile(
                  activeColor: Colors.blueAccent,
                  value: true,
                  groupValue: _notExercise,
                  onChanged: (value) {
                    setState(() {
                      _notExercise = value;
                      _isExercise = false;
                      _neverExercise = false;
                    });
                  },
                  title: Text(
                    'Actualmente no hago ejercicio',
                    style: textStyle.titleMedium,
                  ),
                ),
              ),
              SizedBox(height: 16),
              FadeInDown(
                duration: const Duration(milliseconds: 1100),
                child: RadioListTile(
                  activeColor: Colors.blueAccent,
                  value: true,
                  groupValue: _neverExercise,
                  onChanged: (value) {
                    setState(() {
                      _neverExercise = value;
                      _isExercise = false;
                      _notExercise = false;
                    });
                  },
                  title: Text(
                    'Nunca he hecho ejercicio',
                    style: textStyle.titleMedium,
                  ),
                ),
              ),
              SizedBox(height: 16),
              if (_notExercise != null && _notExercise != false) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: CustomInput(
                    label: '¿Qué actividad realizaba?',
                    onChanged: (value) => _whatActivity = value,
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    '¿Hace cuánto no entrena?',
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: size.width * 0.05,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 1600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomInput(
                          label: 'Años',
                          onChanged: (value) => _yearsNotTrained = value,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingresa un valor';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: CustomInput(
                          label: 'Meses',
                          onChanged: (value) => _monthsNotTrained = value,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingresa un valor';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 1900),
                  child: Text(
                    '¿Llevaba mucho tiempo entrenando?',
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: size.width * 0.05,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 2000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomInput(
                          label: 'Años',
                          onChanged: (value) => _yearsNotBeenTraining = value,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingresa un valor';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: CustomInput(
                          label: 'Meses',
                          onChanged: (value) => _monthsNotBeenTraining = value,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingresa un valor';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 2300),
                  child: CustomInput(
                    label: '¿Con qué intención realizaba esta práctica?',
                    onChanged: (value) => _whatIntentionCarryPractice = value,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 2600),
                  child: CustomInput(
                    label: '¿Qué le impidió continuar la práctica?',
                    onChanged:
                        (value) => _preventedHimFromContinuingPractice = value,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor';
                      }
                      return null;
                    },
                  ),
                ),
              },
              SizedBox(height: 16),
              if (_neverExercise != null && _neverExercise != false) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: CustomInput(
                    label: '¿Qué le motiva a iniciar la práctica de ejercicio?',
                    onChanged: (value) => _motivatesStartExercising = value,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor';
                      }
                      return null;
                    },
                  ),
                ),
              },
              FadeInDown(
                duration: const Duration(milliseconds: 1200),
                child: CustomButton(
                  label: 'Guardar',
                  buttonColor: Colors.blueAccent,
                  onPressed: () {
                    _saveData();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
