import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/activity_work/infrastructure/services/local_activity_work_service.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:corpofit_mobile/utils/widgets/custom_input.dart';
import 'package:corpofit_mobile/utils/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActivityWorkScreen extends StatefulWidget {
  const ActivityWorkScreen({super.key});

  @override
  State<ActivityWorkScreen> createState() => _ActivityWorkScreenState();
}

class _ActivityWorkScreenState extends State<ActivityWorkScreen> {
  bool switchValue = false;

  final doForWorkController = TextEditingController();
  final hoursSpendWorkingController = TextEditingController();
  final averageHourSittingController = TextEditingController();
  final averageStandingHoursController = TextEditingController();
  final whichController = TextEditingController();

  @override
  void initState() {
    super.initState();
    doForWorkController.text = '';
    hoursSpendWorkingController.text = '';
    averageHourSittingController.text = '';
    averageStandingHoursController.text = '';
    whichController.text = '';
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      doForWorkController.text = await LocalActivityWorkService.read(
        'do_for_work',
      );

      if (doForWorkController.text.isNotEmpty) {
        context.go('/summary_activity_work');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveActivityWork() async {
    try {
      await LocalActivityWorkService.save(
        'do_for_work',
        doForWorkController.text,
      );
      await LocalActivityWorkService.save(
        'hours_spend_working',
        hoursSpendWorkingController.text,
      );

      await LocalActivityWorkService.save(
        'average_hour_sitting',
        averageHourSittingController.text,
      );

      await LocalActivityWorkService.save(
        'average_standing_hours',
        averageStandingHoursController.text,
      );

      await LocalActivityWorkService.save(
        'activity_represent_pain_discomfort',
        switchValue,
      );

      await LocalActivityWorkService.save('which', whichController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Actividad laboral guardada exitosamente')),
      );
      if (mounted) {
        await _resetForm();
        context.go('/summary_activity_work');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      debugPrint(e.toString());
    }
  }

  Future<void> _resetForm() async {
    doForWorkController.text = '';
    hoursSpendWorkingController.text = '';
    averageHourSittingController.text = '';
    averageStandingHoursController.text = '';
    whichController.text = '';
    switchValue = false;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividad laboral', style: textStyle.titleLarge),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purpleAccent, size: 35),
          onPressed: () => context.go('/physical_activity_questionnaire'),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(15),
            ),
            gradient: LinearGradient(
              colors: [Colors.white70, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              CustomInput(
                label: '¿En qué desempeña laboralmente?',
                onChanged: (value) => doForWorkController.text = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomInput(
                label: '¿Cuántas horas diarias dedica a su trabajo?',
                onChanged: (value) => hoursSpendWorkingController.text = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              CustomInput(
                label: 'Promedio de horas sentado',
                onChanged: (value) => averageHourSittingController.text = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              CustomInput(
                label: 'Promedio de horas de pie',
                onChanged:
                    (value) => averageStandingHoursController.text = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '¿Su actividad laboral representa algún dolor o molestia?',
                      style: textStyle.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomSwitch(
                    value: switchValue,
                    activeColor: Colors.purpleAccent,
                    activeTrackColor: Colors.purple,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              if (switchValue) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 700),
                  child: CustomInput(
                    label: '¿Cuál es el dolor?',
                    onChanged: (value) => whichController.text = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),

                SizedBox(height: 16),
              },

              CustomButton(
                label: 'Guardar',
                buttonColor: Colors.purpleAccent,
                onPressed: () {
                  saveActivityWork();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
