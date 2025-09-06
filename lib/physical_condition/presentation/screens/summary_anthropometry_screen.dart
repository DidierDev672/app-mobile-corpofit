import 'package:corpofit_mobile/physical_condition/infrastructure/infrastructure.dart';
import 'package:corpofit_mobile/physical_condition/presentation/widgets/card_summary_anthropometry_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/domain.dart';
import '../widgets/widgets.dart';

class SummaryAnthropometryScreen extends StatefulWidget {
  const SummaryAnthropometryScreen({super.key});

  @override
  State<SummaryAnthropometryScreen> createState() =>
      _SummaryAnthropometryScreenState();
}

class _SummaryAnthropometryScreenState
    extends State<SummaryAnthropometryScreen> {
  bool _isLoading = false;
  bool _isError = false;
  String _errorMessage = '';

  AnthropometryEntity? anthropometryEntity;

  @override
  void initState() {
    super.initState();
    _loadAnthropometry();
  }

  Future<void> _loadAnthropometry() async {
    setState(() {
      _isLoading = true;
      _isError = false;
      _errorMessage = '';
    });
    try {
      final activity = LocalAntropometryService.read('activity');
      final resultString = LocalAntropometryService.read('result');
      final resultEnumString = LocalAntropometryService.read('resultEnum');
      final clasificationEnumString = LocalAntropometryService.read(
        'clasificationEnum',
      );
      if (activity == null ||
          resultString == null ||
          resultEnumString == null ||
          clasificationEnumString == null) {
        throw Exception('No se encontraron datos');
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
            "Warning: Clasificación no valida:" +
                resultEnumString +
                " no encontrado",
          );
        }
      }

      String? clasificationEnum;
      if (clasificationEnumString != null &&
          clasificationEnumString.isNotEmpty) {
        try {
          clasificationEnum = clasificationEnumString;
        } catch (e) {
          print(
            "Warning: Clasificación no valida:" +
                clasificationEnumString +
                " no encontrado",
          );
        }
      }

      if (resultEnum == null || clasificationEnum == null) {
        throw Exception('No se encontraron datos');
      }

      anthropometryEntity = AnthropometryEntity(
        activity: activity,
        result: result,
        resultEnum: resultEnum,
        clasificationEnum: clasificationEnum,
      );
    } catch (e) {
      print('Error cargando antropometría: $e');
      setState(() {
        _isError = true;
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
          'Resumen Antropometría',
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
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_isError) {
      return BuildErrorWidget(errorMessage: _errorMessage);
    }

    if (anthropometryEntity == null) {
      return BuildNotDataWidget();
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: CardSummaryAnthropometryWidget(
        anthropometryEntity: anthropometryEntity!,
      ),
    );
  }
}
