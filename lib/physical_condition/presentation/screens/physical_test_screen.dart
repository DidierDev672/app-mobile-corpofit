import 'package:corpofit_mobile/physical_condition/infrastructure/services/local_physical_test_service.dart';
import 'package:corpofit_mobile/utils/widgets/custom_input.dart';
import 'package:corpofit_mobile/utils/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhysicalTestScreen extends StatefulWidget {
  const PhysicalTestScreen({super.key});

  @override
  State<PhysicalTestScreen> createState() => _PhysicalTestScreenState();
}

class _PhysicalTestScreenState extends State<PhysicalTestScreen> {
  String? resultMValue;
  String? clasificationValue;
  List<String> resultM = ['Metros', 'Kilometros'];
  List<String> clasification = ['Excelente', 'Bueno', 'Regular', 'Malo'];

  final activity = TextEditingController();
  final resultMController = TextEditingController();

  bool _hasExistingData = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyData();
    });
  }

  @override
  void dispose() {
    activity.dispose();
    resultMController.dispose();
    super.dispose();
  }

  Future<void> _savePhysicalTest() async {
    try {
      await LocalPhysicalTestService.save('activity', activity.text);
      await LocalPhysicalTestService.save('result', resultMController.text);
      await LocalPhysicalTestService.save('resultEnum', resultMValue);
      await LocalPhysicalTestService.save('classification', clasificationValue);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prueba física guardada exitosamente')),
      );

      if (mounted) {
        context.go('/summary_physical_test');
      }
    } catch (e) {
      print('Error guardando prueba física: $e');
    }
  }

  Future<void> _verifyData() async {
    String activity = await LocalPhysicalTestService.read('activity');
    if (activity != null && activity.isNotEmpty) {
      setState(() {
        _hasExistingData = true;
      });
      if (mounted) {
        context.go('/summary_physical_test');
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
          'Prueba Física',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2.5,
                      offset: const Offset(0, 2.5),
                    ),
                  ],
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa una actividad física';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Resultado',
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: size.width * 0.03),
                  Text(
                    'Clasificación',
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: size.width * 0.04,
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
                      label: 'Valor del resultado',
                      hint: '25',
                      keyboardType: TextInputType.number,
                      onChanged: (value) => resultMController.text = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa un valor';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: DropdownButton<String>(
                      value: resultMValue,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(15),
                      hint: Text(
                        'Metros',
                        style: textStyle.titleMedium?.copyWith(
                          fontSize: size.width * 0.04,
                        ),
                      ),
                      items:
                          resultM
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: textStyle.titleMedium?.copyWith(
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          resultMValue = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: DropdownButton<String>(
                      value: clasificationValue,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(15),
                      hint: Text(
                        'Clasificación',
                        style: textStyle.titleMedium?.copyWith(
                          fontSize: size.width * 0.04,
                        ),
                      ),
                      items:
                          clasification
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: textStyle.titleMedium?.copyWith(
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          clasificationValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: 250,
                height: 65,
                child: CustomButton(
                  buttonColor: Colors.blue,
                  textColor: Colors.white,
                  label: 'Guardar',
                  onPressed: () {
                    _savePhysicalTest();
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
