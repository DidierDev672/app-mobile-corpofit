import 'package:corpofit_mobile/leisure/infrastructure/infrastructure.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:corpofit_mobile/utils/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeisureScreen extends StatefulWidget {
  const LeisureScreen({super.key});

  @override
  State<LeisureScreen> createState() => _LeisureScreenState();
}

class _LeisureScreenState extends State<LeisureScreen> {
  final activityController = TextEditingController();
  final manyDaysWeekController = TextEditingController();
  final timePerDayController = TextEditingController();
  final sleepHoursController = TextEditingController();
  final sleepMinutesController = TextEditingController();
  final recoveredOrRestedController = TextEditingController();
  final timeToGetUpController = TextEditingController();
  final minutesAfterGettingUpController = TextEditingController();
  final bedtimeController = TextEditingController();
  final minuteToSleepController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    activityController.clear();
    manyDaysWeekController.clear();
    timePerDayController.clear();
    sleepHoursController.clear();
    sleepMinutesController.clear();
    recoveredOrRestedController.clear();
    timeToGetUpController.clear();
    minutesAfterGettingUpController.clear();
    bedtimeController.clear();
    minuteToSleepController.clear();
    setState(() {
      isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyData();
    });
  }

  Future<bool> _save() async {
    setState(() {
      isLoading = true;
    });

    if (!await _validateForm()) {
      setState(() {
        isLoading = false;
      });
      return false;
    }

    LocalLeisureService.save('activity', activityController.text);
    LocalLeisureService.save('manyDaysWeek', manyDaysWeekController.text);
    LocalLeisureService.save('timePerDay', timePerDayController.text);
    LocalLeisureService.save('sleepHours', sleepHoursController.text);
    LocalLeisureService.save('sleepMinutes', sleepMinutesController.text);
    LocalLeisureService.save(
      'recoveredOrRested',
      recoveredOrRestedController.text,
    );
    LocalLeisureService.save('timeToGetUp', timeToGetUpController.text);
    LocalLeisureService.save(
      'minutesAfterGettingUp',
      minutesAfterGettingUpController.text,
    );
    LocalLeisureService.save('bedtime', bedtimeController.text);
    LocalLeisureService.save('minuteToSleep', minuteToSleepController.text);

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Guardado exitoso')));

    _resetForm();
    context.go('/summary_leisure');
    return true;
  }

  Future<bool> _validateForm() async {
    if (activityController.text.isEmpty ||
        manyDaysWeekController.text.isEmpty ||
        timePerDayController.text.isEmpty ||
        sleepHoursController.text.isEmpty ||
        sleepMinutesController.text.isEmpty ||
        recoveredOrRestedController.text.isEmpty ||
        timeToGetUpController.text.isEmpty ||
        minutesAfterGettingUpController.text.isEmpty ||
        bedtimeController.text.isEmpty ||
        minuteToSleepController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return false;
    }
    return true;
  }

  Future<void> _resetForm() async {
    activityController.clear();
    manyDaysWeekController.clear();
    timePerDayController.clear();
    sleepHoursController.clear();
    sleepMinutesController.clear();
    recoveredOrRestedController.clear();
    timeToGetUpController.clear();
    minutesAfterGettingUpController.clear();
    bedtimeController.clear();
    minuteToSleepController.clear();
  }

  Future<void> _verifyData() async {
    try {
      final existingActivity = LocalLeisureService.read('activity') ?? '';

      if (existingActivity.isNotEmpty) {
        if (mounted) {
          context.go('/summary_leisure');
        }

        return;
      }
    } catch (e) {
      debugPrint('Error verficando datos existentes: $e');
    }
  }

  @override
  void dispose() {
    activityController.dispose();
    manyDaysWeekController.dispose();
    timePerDayController.dispose();
    sleepHoursController.dispose();
    sleepMinutesController.dispose();
    recoveredOrRestedController.dispose();
    timeToGetUpController.dispose();
    minutesAfterGettingUpController.dispose();
    bedtimeController.dispose();
    minuteToSleepController.dispose();
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiempo libre', style: textStyle.titleLarge),
        leading: IconButton(
          onPressed: () {
            context.go('/physical_activity_questionnaire');
          },
          icon: Icon(Icons.arrow_back_outlined, size: 35, color: Colors.orange),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '¿En su tiempo libre qué actividades realiza?',
                style: textStyle.titleMedium,
              ),
              SizedBox(height: 16),
              CustomInput(
                label: 'Actividad',
                hint: 'Orginizar la parcela',
                onChanged: (value) => activityController.text = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una actividad';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomInput(
                label: '¿Cuántos días a la semana?',
                hint: '2',
                onChanged: (value) => manyDaysWeekController.text = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un número';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomInput(
                label: '¿Tiempo por día (Horas)?',
                hint: '6',
                onChanged: (value) => timePerDayController.text = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un número';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                '¿Cuánto tiempo duerme por día?',
                style: textStyle.titleMedium,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomInput(
                      label: 'Horas',
                      hint: '5',
                      onChanged: (value) => sleepHoursController.text = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un número';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomInput(
                      label: 'Minutos',
                      hint: '30',
                      keyboardType: TextInputType.number,
                      onChanged: (value) => sleepMinutesController.text = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un número';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                '¿Siente que su descanso es reparador o se levanta cansado?',
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.04,
                ),
              ),
              SizedBox(height: 16),
              CustomInput(
                label: 'Descripción',
                hint: 'Paso toda la mañana con sueño',
                onChanged: (value) => recoveredOrRestedController.text = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                '¿Generalmente a qué hora se levanta y a qué hora se acuesta?',
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.04,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Hora de levantarse',
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.04,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomInput(
                      label: 'Hora',
                      hint: '7:00',
                      keyboardType: TextInputType.number,
                      onChanged: (value) => timeToGetUpController.text = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa una hora';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomInput(
                      label: 'Minutos',
                      hint: '30',
                      keyboardType: TextInputType.number,
                      onChanged:
                          (value) =>
                              minutesAfterGettingUpController.text = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa minutos';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Hora de levantarse',
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.04,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomInput(
                      label: 'Hora',
                      hint: '7:00',
                      keyboardType: TextInputType.number,
                      onChanged: (value) => bedtimeController.text = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa una hora';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomInput(
                      label: 'Minutos',
                      hint: '30',
                      keyboardType: TextInputType.number,
                      onChanged:
                          (value) => minuteToSleepController.text = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa minutos';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              CustomButton(
                label: isLoading ? 'Guardando...' : 'Guardar',
                buttonColor: Colors.orange,
                onPressed: () {
                  _save();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
