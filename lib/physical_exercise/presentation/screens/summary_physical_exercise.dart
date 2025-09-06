import 'package:corpofit_mobile/physical_exercise/domain/domain.dart';
import 'package:corpofit_mobile/physical_exercise/infrastructure/services/local_physical_exercise.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class SummaryPhysicalExercise extends StatefulWidget {
  const SummaryPhysicalExercise({super.key});

  @override
  State<SummaryPhysicalExercise> createState() =>
      _SummaryPhysicalExerciseState();
}

class _SummaryPhysicalExerciseState extends State<SummaryPhysicalExercise> {
  bool? _isLoading = false;
  bool? _isError = false;

  PhysicalExercise? _physicalExercise;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _physicalExercise = PhysicalExercise(
        isExercise: LocalPhysicalExercise.read<bool>('isExercise') ?? false,
        notExercise: LocalPhysicalExercise.read<bool>('notExercise') ?? false,
        neverExercise:
            LocalPhysicalExercise.read<bool>('neverExercise') ?? false,
        whatActivity: LocalPhysicalExercise.read<String>('whatActivity') ?? '',
        yearsNotTrained:
            LocalPhysicalExercise.read<String>('yearsNotTrained') ?? '',
        monthsNotTrained:
            LocalPhysicalExercise.read<String>('monthsNotTrained') ?? '',
        yearsNotBeenTraining:
            LocalPhysicalExercise.read<String>('yearsNotBeenTraining') ?? '',
        monthsNotBeenTraining:
            LocalPhysicalExercise.read<String>('monthsNotBeenTraining') ?? '',
        whatIntentionCarryPractice:
            LocalPhysicalExercise.read<String>('whatIntentionCarryPractice') ??
            '',
        preventedHimFromContinuingPractice:
            LocalPhysicalExercise.read<String>(
              'preventedHimFromContinuingPractice',
            ) ??
            '',
        motivatesStartExercising:
            LocalPhysicalExercise.read<String>('motivatesStartExercising') ??
            '',
      );

      if (_physicalExercise != null) {
        setState(() {
          _isError = false;
          _isLoading = false;
        });
      }

      if (_physicalExercise == null) {
        setState(() {
          _isError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    if (_isLoading == true) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_isError == true) {
      return const Center(child: Text('Error'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen Ejercicio Fisico', style: textStyle.titleLarge),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
            size: 35,
          ),
          onPressed: () {
            context.go('/physical_activity_questionnaire');
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CardPhysicalExerciseWidget(
            physicalExercise: _physicalExercise!,
          ),
        ),
      ),
    );
  }
}
