import 'package:corpofit_mobile/physical_condition/domain/domain.dart';
import 'package:corpofit_mobile/physical_condition/infrastructure/services/local_clinical_screening_service.dart';
import 'package:corpofit_mobile/physical_condition/presentation/widgets/build_error_widget.dart';
import 'package:corpofit_mobile/physical_condition/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SummaryClinicalScreeningScreen extends StatefulWidget {
  const SummaryClinicalScreeningScreen({super.key});

  @override
  State<SummaryClinicalScreeningScreen> createState() =>
      _SummaryClinicalScreeningScreenState();
}

class _SummaryClinicalScreeningScreenState
    extends State<SummaryClinicalScreeningScreen> {
  bool _isLoading = false;
  bool _isError = false;
  String _errorMessage = '';

  ClinicalScreeningEntity? _clinicalScreening;

  @override
  void initState() {
    super.initState();

    _loadClinicalScreening();
  }

  Future<void> _loadClinicalScreening() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final activity = LocalClinicalScreeningService.read('activity');
      final result = LocalClinicalScreeningService.read('result');
      final resultEnum = LocalClinicalScreeningService.read('resultEnum');
      final clasificationEnum = LocalClinicalScreeningService.read(
        'classification',
      );

      if (activity == null || activity.isEmpty) {
        throw Exception('No se encontró información del tamizaje clínico');
      }

      if (result == null || result.isEmpty) {
        throw Exception('No se encontró resultado del tamizaje clínico');
      }

      double resultNumeric;
      try {
        resultNumeric = double.parse(result);
      } catch (e) {
        throw Exception('El resultado no es un número válido: $result');
      }

      if (resultEnum == null || resultEnum.isEmpty) {
        throw Exception('No se encontró tipo de resultado válido');
      }

      if (clasificationEnum == null || clasificationEnum.isEmpty) {
        throw Exception('No se encontró clasificación válida');
      }

      _clinicalScreening = ClinicalScreeningEntity(
        activity: activity,
        result: resultNumeric,
        resultEnum: resultEnum,
        classification: clasificationEnum,
      );
    } catch (e) {
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
          'Resumen Tamizaje Clínico',
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

    if (_isError) {
      return BuildErrorWidget(errorMessage: _errorMessage);
    }

    if (_clinicalScreening == null) {
      return BuildNotDataWidget();
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: CardClinialScreeningWidget(clinicalScreening: _clinicalScreening!),
    );
  }
}
