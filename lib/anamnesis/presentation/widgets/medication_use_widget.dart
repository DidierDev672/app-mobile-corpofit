import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_medication_user_service.dart';
import 'package:corpofit_mobile/utils/widgets/date_picker_field.dart';
import 'package:flutter/material.dart';
import '../../../utils/widgets/widget.dart';

class MedicationUseWidget extends StatefulWidget {
  const MedicationUseWidget({super.key});

  @override
  State<MedicationUseWidget> createState() => _MedicationUseWidgetState();
}

class _MedicationUseWidgetState extends State<MedicationUseWidget> {
  final TextEditingController dateInput = TextEditingController();
  bool _smoke = false;
  bool _frequently_taken_medications = false;
  bool _mother_or_father_any_illnes = false;
  bool qar_p = false;
  DateTime _lastMedicalCheckUp = new DateTime.now();
  bool _remember = false;
  String _nameOfMedication = '';
  String _nameOfIllnes = '';
  bool _isLoading = false;

  @override
  void initState() {
    dateInput.text = "";
    _smoke = false;
    _frequently_taken_medications = false;
    _mother_or_father_any_illnes = false;
    qar_p = false;
    _lastMedicalCheckUp = DateTime.now();
    _remember = false;
    _nameOfMedication = '';
    _nameOfIllnes = '';
    _isLoading = false;
    super.initState();
  }

  Future<void> _saveMedication() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await LocalMedicationUserService.save(
        'frequently_taken_medications',
        _frequently_taken_medications,
      );

      await LocalMedicationUserService.save(
        'name_of_medication',
        _nameOfMedication,
      );

      await LocalMedicationUserService.save(
        'last_medical_check_up',
        _lastMedicalCheckUp.toString(),
      );

      await LocalMedicationUserService.save('remember', _remember);
      await LocalMedicationUserService.save(
        'mother_or_father_any_illnes',
        _mother_or_father_any_illnes,
      );

      await LocalMedicationUserService.save('name_of_illnes', _nameOfIllnes);
      await LocalMedicationUserService.save('smoke', _smoke);
      await LocalMedicationUserService.save('qar_p', qar_p);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Información guardada correctamente')),
      );

      resetForm();
    } catch (e) {
      debugPrint('Error saving medication: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> resetForm() async {
    setState(() {
      _smoke = false;
      _frequently_taken_medications = false;
      _mother_or_father_any_illnes = false;
      qar_p = false;
      _lastMedicalCheckUp = DateTime.now();
      _remember = false;
      _nameOfMedication = '';
      _nameOfIllnes = '';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: Text('Medicación frecuente', style: textTheme.titleLarge),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '¿Consume algún medicamento frecuente?',
                style: textTheme.titleSmall,
              ),
            ),
            Switch(
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
              value: _frequently_taken_medications,
              onChanged: (value) {
                setState(() {
                  _frequently_taken_medications = value;
                });
              },
            ),
          ],
        ),
        if (_frequently_taken_medications == true) ...{
          SizedBox(height: 20),
          CustomInput(
            label: '¿Cual es el medicamento?',
            onChanged: (value) {
              setState(() {
                _nameOfMedication = value;
              });
            },
          ),
        },

        SizedBox(height: 20),
        Text(
          '¿Cúando fue su último control médico?',
          style: textTheme.titleSmall,
        ),
        SizedBox(height: 10),
        DatePickerField(
          label: 'Seleccionar la fecha',
          controller: TextEditingController(
            text: _lastMedicalCheckUp.toString(),
          ),
        ),
        SizedBox(height: 10),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('No recuerdo', style: textTheme.titleSmall),
          value: _remember,
          onChanged: (value) {
            setState(() {
              _remember = value!;
            });
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '¿Su madre o padre tiene alguna enfermedad?',
                style: textTheme.titleSmall,
              ),
            ),

            Switch(
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
              value: _mother_or_father_any_illnes,
              onChanged: (value) {
                setState(() {
                  _mother_or_father_any_illnes = value;
                });
              },
            ),
          ],
        ),
        if (_mother_or_father_any_illnes) ...{
          SizedBox(height: 10),
          CustomInput(
            label: '¿Cual es el enfermedad?',
            onChanged: (value) {
              setState(() {
                _nameOfIllnes = value;
              });
            },
          ),
        },

        SizedBox(height: 20),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('¿Fuma?', style: textTheme.titleSmall),
          value: _smoke,
          onChanged: (value) {
            setState(() {
              _smoke = value!;
            });
          },
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.greenAccent, Colors.deepPurple],
            ),
          ),
          child: Center(
            child: Text(
              'PAR-Q',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          '¿Alguna vez le ha diagnosticado su médico un problema en el corazón, recomendándole que solo haga deporte bajo supervisión médica?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        Switch(
          activeColor: Colors.green,
          inactiveThumbColor: Colors.grey,
          value: qar_p,
          onChanged: (value) {
            setState(() {
              qar_p = value;
            });
          },
        ),
        SizedBox(height: 20),
        CustomButton(
          label: _isLoading ? 'Guardando...' : 'Guardar',
          buttonColor: _isLoading ? Colors.grey : Colors.blue,
          onPressed: () {
            if (_isLoading) return;
            _saveMedication();
          },
        ),
      ],
    );
  }
}
