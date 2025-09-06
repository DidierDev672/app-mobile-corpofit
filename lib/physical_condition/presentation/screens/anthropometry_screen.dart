import 'package:corpofit_mobile/physical_condition/infrastructure/services/local_antropometry_service.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:corpofit_mobile/utils/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnthropometryScreen extends StatefulWidget {
  const AnthropometryScreen({super.key});

  @override
  State<AnthropometryScreen> createState() => _AnthropometryScreenState();
}

class _AnthropometryScreenState extends State<AnthropometryScreen> {
  String _valueActivity = '';
  String _resultMValue = '';
  String _resultMClassification = '';
  List<String> resultM = ['Libras', 'Kilogramos'];
  List<String> resultMClassification = ['Alto', 'Normal', 'Bajo'];

  final activity = TextEditingController();

  @override
  void initState() {
    super.initState();
    _resultMValue = resultM.first;
    _resultMClassification = resultMClassification.first;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyData();
    });
  }

  Future<void> _saveAnthropometry() async {
    await LocalAntropometryService.save('activity', activity.text);
    await LocalAntropometryService.save('result', _valueActivity);
    await LocalAntropometryService.save('resultEnum', _resultMValue);
    await LocalAntropometryService.save(
      'clasificationEnum',
      _resultMClassification,
    );

    if (mounted) {
      context.go('/summary_anthropometry');
    }
  }

  Future<void> _verifyData() async {
    String activity = await LocalAntropometryService.read('activity') ?? '';
    if (activity.isNotEmpty) {
      context.go('/summary_anthropometry');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Antropometría',
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
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                onChanged: (value) => activity.text = value,
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Resultado', style: textStyle.titleMedium),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Text('Calificación', style: textStyle.titleMedium),
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
                      onChanged: (value) => _valueActivity = value,
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
                        borderRadius: BorderRadius.circular(8),
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: _resultMClassification,
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
                            resultMClassification
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _resultMClassification = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: 200,
                height: 50,
                child: CustomButton(
                  label: 'Guardar',
                  buttonColor: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _saveAnthropometry();
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
