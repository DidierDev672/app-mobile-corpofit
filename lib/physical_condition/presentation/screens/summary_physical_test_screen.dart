import 'package:corpofit_mobile/physical_condition/presentation/widgets/build_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';
import '../widgets/widgets.dart';

class SummaryPhysicalTestScreen extends StatefulWidget {
  const SummaryPhysicalTestScreen({super.key});

  @override
  State<SummaryPhysicalTestScreen> createState() =>
      _SummaryPhysicalTestScreenState();
}

class _SummaryPhysicalTestScreenState extends State<SummaryPhysicalTestScreen> {
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;

  PhysicalTestEntities? physicalTestEntities;

  @override
  void initState() {
    super.initState();
    _loadPhysicalTest();
  }

  Future<void> _loadPhysicalTest() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      final activity = LocalPhysicalTestService.read('activity');
      final resultString = LocalPhysicalTestService.read('result');
      final resultEnumString = LocalPhysicalTestService.read('resultEnum');
      final classificationString = LocalPhysicalTestService.read(
        'classification',
      );

      if (activity == null || activity.isEmpty) {
        throw Exception('No se encontró información de actividad');
      }

      if (resultString == null || resultEnumString.isEmpty) {
        throw Exception('No se encontró resultado');
      }

      double result;
      try {
        result = double.parse(resultString);
      } catch (e) {
        throw Exception('El resultado no es un número válido: $resultString');
      }

      String? resultEnum;
      if (resultEnumString != null && resultEnumString.isNotEmpty) {
        try {
          resultEnum = resultEnumString;
        } catch (e) {
          print(
            'Warning: Resultado no valido: ' +
                resultEnumString +
                ' no encontrado',
          );
        }
      }

      String? clasificationEnum;
      if (classificationString != null && classificationString.isNotEmpty) {
        try {
          clasificationEnum = classificationString;
        } catch (e) {
          print(
            'Warning: Clasificación no valida: ' +
                classificationString +
                ' no encontrado',
          );
        }
      }

      if (resultEnum == null) {
        throw Exception('No se encontró tipo de resultado válido');
      }

      if (clasificationEnum == null) {
        throw Exception('No se encontró clasificación válida');
      }

      physicalTestEntities = PhysicalTestEntities(
        activity: activity,
        result: result,
        resultEnum: resultEnum,
        classification: clasificationEnum,
      );
    } catch (e) {
      print('Error cargando prueba física: $e');
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resumen de Prueba Física',
          style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
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
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return BuildErrorWidget(errorMessage: _errorMessage!);
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: CardPhysicalTestWidget(
        physicalTestEntities: physicalTestEntities!,
      ),
    );
  }
}
