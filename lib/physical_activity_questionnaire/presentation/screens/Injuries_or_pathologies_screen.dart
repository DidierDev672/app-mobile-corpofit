import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/physical_activity_questionnaire/insfrastructure/services/local_Injuries_or_pathology_service.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:corpofit_mobile/utils/widgets/custom_input.dart';
import 'package:corpofit_mobile/utils/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InjuriesOrPathologiesScreen extends StatefulWidget {
  const InjuriesOrPathologiesScreen({super.key});

  @override
  State<InjuriesOrPathologiesScreen> createState() =>
      _InjuriesOrPathologiesScreenState();
}

class _InjuriesOrPathologiesScreenState
    extends State<InjuriesOrPathologiesScreen> {
  bool _beenInjured = false;
  bool _treatedMedically = false;
  bool _physicalPainOrDiscomfort = false;
  bool _havePathologies = false;
  bool _tratedMedically = false;

  bool _verified = false;

  final _indicateInjuryOneController = TextEditingController();
  final _longAgoOneController = TextEditingController();

  final _indicateInjuryTwoController = TextEditingController();
  final _longAgoTwoController = TextEditingController();
  final _preventsFromDoingController = TextEditingController();

  final _indicateInjuryThreeController = TextEditingController();
  final _longAgoThreeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _beenInjured = false;
    _treatedMedically = false;
    _physicalPainOrDiscomfort = false;
    _havePathologies = false;
    _tratedMedically = false;
    _verified = LocalInjuriesOrPathologyService.read('been_injured') ?? false;
  }

  @override
  void dispose() {
    _indicateInjuryOneController.dispose();
    _longAgoOneController.dispose();
    _indicateInjuryTwoController.dispose();
    _longAgoTwoController.dispose();
    _preventsFromDoingController.dispose();
    _indicateInjuryThreeController.dispose();
    _longAgoThreeController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    try {
      _verify();
      if (_verified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ya cuenta con datos almacenados')),
        );
        return;
      }
      await LocalInjuriesOrPathologyService.save('been_injured', _beenInjured);
      if (_beenInjured) {
        await LocalInjuriesOrPathologyService.save(
          'indicate_injury_one',
          _indicateInjuryOneController.text,
        );

        await LocalInjuriesOrPathologyService.save(
          'long_ago_one',
          _longAgoOneController.text,
        );
      }

      await LocalInjuriesOrPathologyService.save(
        'treated_medically',
        _treatedMedically,
      );

      await LocalInjuriesOrPathologyService.save(
        'physical_pain_or_discomfort',
        _physicalPainOrDiscomfort,
      );

      if (_physicalPainOrDiscomfort) {
        await LocalInjuriesOrPathologyService.save(
          'indicate_injury_two',
          _indicateInjuryTwoController.text,
        );

        await LocalInjuriesOrPathologyService.save(
          'long_ago_two',
          _longAgoTwoController.text,
        );

        await LocalInjuriesOrPathologyService.save(
          'prevents_from_doing',
          _preventsFromDoingController.text,
        );
      }

      await LocalInjuriesOrPathologyService.save(
        'have_pathologies',
        _havePathologies,
      );

      if (_havePathologies) {
        await LocalInjuriesOrPathologyService.save(
          'indicate_injury_three',
          _indicateInjuryThreeController.text,
        );

        await LocalInjuriesOrPathologyService.save(
          'long_ago_three',
          _longAgoThreeController.text,
        );

        await LocalInjuriesOrPathologyService.save(
          'trated_medically',
          _tratedMedically,
        );
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Datos guardados correctamente')));
      _resetForm();

      context.go('/summary_injuries_or_pathologies');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar datos: ${e.toString()}')),
      );

      debugPrint('Error al guardar datos: ${e.toString()}');
    }
  }

  Future<void> _resetForm() async {
    setState(() {
      _beenInjured = false;
      _treatedMedically = false;
      _physicalPainOrDiscomfort = false;
      _havePathologies = false;
      _tratedMedically = false;
      _indicateInjuryOneController.clear();
      _longAgoOneController.clear();
      _indicateInjuryTwoController.clear();
      _longAgoTwoController.clear();
      _preventsFromDoingController.clear();
      _indicateInjuryThreeController.clear();
      _longAgoThreeController.clear();
    });
  }

  Future<void> _verify() async {
    setState(() {
      _verified = LocalInjuriesOrPathologyService.read('been_injured') ?? false;
    });

    if (_verified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ya cuenta con datos almacenados')),
      );
      context.go('/summary_injuries_or_pathologies');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lesiones o Pathologías',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/physical_activity_questionnaire');
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(20),
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
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '¿Alguna vez se ha lesionado?',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  CustomSwitch(
                    value: _beenInjured,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blue.shade200,
                    inactiveText: 'No',
                    activeText: 'Sí',
                    onChanged: (value) {
                      setState(() {
                        _beenInjured = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              if (_beenInjured) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: CustomInput(
                    label: 'Indique la lesión',
                    onChanged:
                        (value) => setState(() {
                          _indicateInjuryOneController.text = value;
                        }),
                  ),
                ),
                SizedBox(height: 15),
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: CustomInput(
                    label: 'Hace cuánto (meses)',
                    onChanged: (value) => _longAgoOneController.text = value,
                  ),
                ),
                SizedBox(height: 15),
              },

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '¿Fue tratada médicamente?',
                      style: textTheme.titleMedium,
                    ),
                  ),
                  CustomSwitch(
                    value: _treatedMedically,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blue.shade200,
                    inactiveText: 'No',
                    activeText: 'Sí',
                    onChanged: (value) {
                      setState(() {
                        _treatedMedically = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '¿Presenta algún dolor o molestia física?',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  CustomSwitch(
                    value: _physicalPainOrDiscomfort,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blue.shade200,
                    inactiveText: 'No',
                    activeText: 'Sí',
                    onChanged: (value) {
                      setState(() {
                        _physicalPainOrDiscomfort = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              if (_physicalPainOrDiscomfort) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: CustomInput(
                    label: 'Indique el dolor',
                    onChanged:
                        (value) => _indicateInjuryTwoController.text = value,
                  ),
                ),

                SizedBox(height: 15),
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: CustomInput(
                    label: 'Hace cuánto (meses)',
                    onChanged: (value) => _longAgoTwoController.text = value,
                    keyboardType: TextInputType.number,
                  ),
                ),

                SizedBox(height: 15),
                FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: CustomInput(
                    label: '¿Qué le impide realizar?',
                    onChanged:
                        (value) => _preventsFromDoingController.text = value,
                  ),
                ),
              },
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '¿Tiene alguna patología?',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  CustomSwitch(
                    value: _havePathologies,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blue.shade200,
                    inactiveText: 'No',
                    activeText: 'Sí',
                    onChanged: (value) {
                      setState(() {
                        _havePathologies = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              if (_havePathologies) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: CustomInput(
                    label: 'Inquique la patología',
                    onChanged:
                        (value) => _indicateInjuryThreeController.text = value,
                  ),
                ),
                SizedBox(height: 15),
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: CustomInput(
                    label: 'Hace cuánto (meses)',
                    onChanged: (value) => _longAgoThreeController.text = value,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 15),
                FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '¿Fue tratada médicamente?',
                          style: textTheme.titleMedium,
                        ),
                      ),
                      CustomSwitch(
                        value: _tratedMedically,
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue.shade200,
                        inactiveText: 'No',
                        activeText: 'Sí',
                        onChanged: (value) {
                          setState(() {
                            _tratedMedically = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              },

              SizedBox(height: 15),
              CustomButton(
                label: 'Guardar',
                buttonColor: Colors.blueAccent,
                onPressed: () {
                  _save();
                },
              ),
              if (_verified) ...{
                SizedBox(height: 15),
                CustomButton(
                  label: 'Ver resumen',
                  buttonColor: Colors.purpleAccent,
                  onPressed: () {
                    context.go('/summary_injuries_or_pathologies');
                  },
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
