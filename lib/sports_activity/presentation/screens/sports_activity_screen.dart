import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:corpofit_mobile/utils/widgets/custom_input.dart';
import 'package:corpofit_mobile/utils/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../infrastructure/infrastructure.dart';

class SportsActivityScreen extends StatefulWidget {
  const SportsActivityScreen({super.key});

  @override
  State<SportsActivityScreen> createState() => _SportsActivityScreenState();
}

class _SportsActivityScreenState extends State<SportsActivityScreen> {
  bool playIsSport = false;
  bool practiceCauseDisconfort = false;

  bool _sportRecreation = false;
  bool _sportFormation = true;
  bool _sportProfessional = true;
  bool _sportBeauty = true;
  bool _sportHealth = true;

  final whichSportController = TextEditingController();
  final indicateAnnoyanceController = TextEditingController();
  final dayWeekController = TextEditingController();
  final timeDayController = TextEditingController();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final practiceCauseDiscomfortController = TextEditingController();

  @override
  void initState() {
    super.initState();
    playIsSport = false;
    practiceCauseDisconfort = false;
    _sportRecreation = false;
    _sportFormation = false;
    _sportProfessional = false;
    _sportBeauty = false;
    _sportHealth = false;
    whichSportController.clear();
    indicateAnnoyanceController.clear();
    dayWeekController.clear();
    timeDayController.clear();
    yearController.clear();
    monthController.clear();
    practiceCauseDiscomfortController.clear();
    _verify();
  }

  Future<void> _verify() async {
    playIsSport =
        await LocalSportsActivityService.read('play_any_sport') ?? false;

    if (playIsSport) {
      context.go('/summary_sports_activity');
    }
  }

  Future<void> save() async {
    try {
      await LocalSportsActivityService.save('play_any_sport', playIsSport);
      await LocalSportsActivityService.save(
        'which_sport',
        whichSportController.text,
      );
      await LocalSportsActivityService.save(
        'indicate_annoyance',
        indicateAnnoyanceController.text,
      );
      await LocalSportsActivityService.save('day_week', dayWeekController.text);
      await LocalSportsActivityService.save('time_day', timeDayController.text);
      await LocalSportsActivityService.save('year', yearController.text);
      await LocalSportsActivityService.save('month', monthController.text);
      await LocalSportsActivityService.save(
        'practice_cause_disconfort',
        practiceCauseDisconfort,
      );
      await LocalSportsActivityService.save(
        'sport_recreation',
        _sportRecreation,
      );
      await LocalSportsActivityService.save('sport_formation', _sportFormation);
      await LocalSportsActivityService.save(
        'sport_professional',
        _sportProfessional,
      );
      await LocalSportsActivityService.save('sport_beauty', _sportBeauty);
      await LocalSportsActivityService.save('sport_health', _sportHealth);
      await LocalSportsActivityService.save(
        'which',
        practiceCauseDiscomfortController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos guardados correctamente')),
        );
        await _resetForm();
        context.go('/summary_sports_activity');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
      debugPrint(e.toString());
    }
  }

  Future<void> _resetForm() async {
    setState(() {
      playIsSport = false;
      practiceCauseDisconfort = false;
      _sportRecreation = false;
      _sportFormation = false;
      _sportProfessional = false;
      _sportBeauty = false;
      _sportHealth = false;
      whichSportController.clear();
      indicateAnnoyanceController.clear();
      dayWeekController.clear();
      timeDayController.clear();
      yearController.clear();
      monthController.clear();
      practiceCauseDiscomfortController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Actividad laboral')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white70, Colors.white],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '¿Practica algún deporte?',
                      style: textStyle.titleMedium,
                    ),
                  ),
                  CustomSwitch(
                    value: playIsSport,
                    activeColor: Colors.yellowAccent,
                    inactiveTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.amberAccent,
                    onChanged: (value) {
                      setState(() {
                        playIsSport = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (playIsSport) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: CustomInput(
                    label: '¿Cual?',
                    hint: 'Fútbol sala, Basketball',
                    onChanged: (value) => whichSportController.text = value,
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
                  duration: const Duration(milliseconds: 600),
                  child: CustomInput(
                    label: 'Indique la molestia',
                    hint: 'Dolor de hombro, dolor de cadera',
                    onChanged:
                        (value) => indicateAnnoyanceController.text = value,
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
                  duration: const Duration(milliseconds: 700),
                  child: CustomInput(
                    label: 'Días a la semana',
                    hint: '3',
                    keyboardType: TextInputType.number,
                    onChanged: (value) => dayWeekController.text = value,
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
                  duration: const Duration(milliseconds: 800),
                  child: CustomInput(
                    label: 'Tiempo por día (minutos)',
                    hint: '2',
                    keyboardType: TextInputType.number,
                    onChanged: (value) => timeDayController.text = value,
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
                  duration: const Duration(milliseconds: 900),
                  child: Text(
                    '¿Hace cuánto practica este deporte?',
                    style: textStyle.titleMedium,
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomInput(
                          label: 'Años',
                          hint: '2',
                          keyboardType: TextInputType.number,
                          onChanged: (value) => yearController.text = value,
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
                          hint: '2',
                          keyboardType: TextInputType.number,
                          onChanged: (value) => monthController.text = value,
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
                  duration: const Duration(milliseconds: 1100),
                  child: Text(
                    'Indique el objectivo de esta practica',
                    style: textStyle.titleMedium,
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 1200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Recreación deportiva',
                          style: textStyle.titleMedium,
                        ),
                      ),
                      Checkbox(
                        value: _sportRecreation,
                        activeColor: Colors.yellowAccent,
                        checkColor: Colors.yellow,
                        onChanged: (value) {
                          setState(() {
                            _sportRecreation = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                FadeInDown(
                  duration: const Duration(milliseconds: 1300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Formación deportiva',
                          style: textStyle.titleMedium,
                        ),
                      ),
                      Checkbox(
                        value: _sportFormation,
                        activeColor: Colors.yellowAccent,
                        checkColor: Colors.yellow,
                        onChanged: (value) {
                          setState(() {
                            _sportFormation = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Preparación profesional',
                          style: textStyle.titleMedium,
                        ),
                      ),
                      Checkbox(
                        value: _sportProfessional,
                        activeColor: Colors.yellowAccent,
                        checkColor: Colors.yellow,
                        onChanged: (value) {
                          setState(() {
                            _sportProfessional = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                FadeInDown(
                  duration: const Duration(milliseconds: 1700),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Resultados estéticos',
                          style: textStyle.titleMedium,
                        ),
                      ),
                      Checkbox(
                        value: _sportBeauty,
                        activeColor: Colors.yellowAccent,
                        checkColor: Colors.yellow,
                        onChanged: (value) {
                          setState(() {
                            _sportBeauty = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                FadeInDown(
                  duration: const Duration(milliseconds: 1800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Estado saludable',
                          style: textStyle.titleMedium,
                        ),
                      ),
                      Checkbox(
                        value: _sportHealth,
                        activeColor: Colors.yellowAccent,
                        checkColor: Colors.yellow,
                        onChanged: (value) {
                          setState(() {
                            _sportHealth = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Realiza esta práctica le genera algún malestar',
                        style: textStyle.titleMedium,
                      ),
                    ),
                    CustomSwitch(
                      value: practiceCauseDisconfort,
                      activeColor: Colors.yellowAccent,
                      inactiveTrackColor: Colors.grey,
                      inactiveThumbColor: Colors.yellow,
                      onChanged: (value) {
                        setState(() {
                          practiceCauseDisconfort = value;
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(height: 16),

                if (practiceCauseDisconfort) ...{
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: CustomInput(
                      label: '¿Cual?',
                      hint: 'Dolor de hombro, dolor de cadera',
                      onChanged:
                          (value) => indicateAnnoyanceController.text = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa un valor';
                        }
                        return null;
                      },
                    ),
                  ),
                },
              },

              SizedBox(height: 16),
              CustomButton(
                label: 'Guardar',
                onPressed: () {
                  save();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
