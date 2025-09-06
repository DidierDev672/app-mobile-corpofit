import 'package:corpofit_mobile/anamnesis/domain/basic_data.dart';
import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_basic_data_service.dart';
import 'package:corpofit_mobile/utils/widgets/date_picker_field.dart';
import 'package:corpofit_mobile/utils/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BasicAnamnesisDataWidget extends StatefulWidget {
  const BasicAnamnesisDataWidget({super.key});

  @override
  State<BasicAnamnesisDataWidget> createState() =>
      _BasicAnamnesisDataWidgetState();
}

class _BasicAnamnesisDataWidgetState extends State<BasicAnamnesisDataWidget> {
  final _formKey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerHeight = TextEditingController();
  final _controllerWeight = TextEditingController();
  final _controllerBirthDate = TextEditingController();
  final _controllerCountry = TextEditingController();
  final _controllerCity = TextEditingController();
  final _controllerAddress = TextEditingController();
  final _controllerRegion = TextEditingController();

  String currentValue = 'Masculino';

  Box<BasicData>? box;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerHeight.dispose();
    _controllerWeight.dispose();
    _controllerBirthDate.dispose();
    _controllerCountry.dispose();
    _controllerCity.dispose();
    _controllerAddress.dispose();
    _controllerRegion.dispose();
    box?.close();
    super.dispose();
  }

  Future<void> _addInfo() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      await LocalBasicDataService.save('name_full', _controllerName.text);
      await LocalBasicDataService.save('height', _controllerHeight.text);
      await LocalBasicDataService.save('weight', _controllerWeight.text);
      await LocalBasicDataService.save('gender', currentValue);
      await LocalBasicDataService.save('birth_date', _controllerBirthDate.text);
      await LocalBasicDataService.save('country', _controllerCountry.text);
      await LocalBasicDataService.save('city', _controllerCity.text);
      await LocalBasicDataService.save('address', _controllerAddress.text);
      await LocalBasicDataService.save('region', _controllerRegion.text);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Datos guardados correctamente')));
      _resetForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar datos: ${e.toString()}')),
      );
      debugPrint('Error al guardar datos: ${e.toString()}');
    }
  }

  void _resetForm() {
    _controllerName.clear();
    _controllerHeight.clear();
    _controllerWeight.clear();
    _controllerBirthDate.clear();
    _controllerCountry.clear();
    _controllerCity.clear();
    _controllerAddress.clear();
    _controllerRegion.clear();
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          CustomInput(
            label: 'Nombre',
            onChanged: (value) => _controllerName.text = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su nombre.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomInput(
            label: 'Peso (KG)',
            onChanged: (value) => _controllerWeight.text = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su peso.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomInput(
            label: 'Estatura (CM)',
            onChanged: (value) => _controllerHeight.text = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su altura.';
              }
              return null;
            },
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: currentValue,
              onChanged: (String? newValue) {
                currentValue = newValue!;
              },
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              focusColor: Colors.grey,
              items: [
                DropdownMenuItem<String>(
                  value: 'Masculino',
                  child: Text('Masculino', style: TextStyle(fontSize: 20)),
                ),
                DropdownMenuItem<String>(
                  value: 'Femenino',
                  child: Text('Femenino', style: TextStyle(fontSize: 20)),
                ),
                DropdownMenuItem<String>(
                  value: 'Otro',
                  child: Text('Otro', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DatePickerField(
            label: 'Fecha de nacimiento',
            controller: _controllerBirthDate,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su fecha de nacimiento.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Lugar de residencia',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomInput(
            label: 'Pais',
            onChanged: (value) => _controllerCountry.text = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su pais.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomInput(
            label: 'Ciudad',
            onChanged: (value) => _controllerCity.text = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su ciudad.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomInput(
            label: 'Departamento',
            onChanged: (value) => _controllerRegion.text = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su departamento.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInput(
            label: 'Dirección domiciliaria',
            onChanged: (value) => _controllerAddress.text = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su dirección domiciliaria.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            label: _isLoading ? 'Guardando...' : 'Guardar',
            buttonColor: _isLoading ? Colors.grey : Colors.blue,
            onPressed: _isLoading ? null : _addInfo,
          ),
        ],
      ),
    );
  }
}
