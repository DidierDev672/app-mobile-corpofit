import 'package:corpofit_mobile/activity_work/infrastructure/services/local_activity_work_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/doman.dart';
import '../widgets/widgets.dart';

class SummaryActivityWorkScreen extends StatefulWidget {
  const SummaryActivityWorkScreen({super.key});

  @override
  State<SummaryActivityWorkScreen> createState() =>
      _SummaryActivityWorkScreenState();
}

class _SummaryActivityWorkScreenState extends State<SummaryActivityWorkScreen> {
  bool _loading = false;
  bool _hasError = false;

  ActivityWork? _activityWork;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
    });
    try {
      await Future.delayed(const Duration(seconds: 2));
      _activityWork = ActivityWork(
        doForWork: LocalActivityWorkService.read<String>('do_for_work') ?? '',
        hoursSpendWorking:
            LocalActivityWorkService.read<String>('hours_spend_working') ?? '',
        averageHourSitting:
            LocalActivityWorkService.read<String>('average_hour_sitting') ?? '',
        averageStandingHours:
            LocalActivityWorkService.read<String>('average_standing_hours') ??
            '',
        activityRepresentPainDiscomfort:
            LocalActivityWorkService.read<bool>(
              'activity_represent_pain_discomfort',
            ) ??
            false,
        which: LocalActivityWorkService.read<String>('which') ?? '',
      );
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_hasError) {
      return const Center(child: Text('Error al cargar los datos'));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resumen de actividad laboral',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.purpleAccent,
            size: 35,
          ),
          onPressed: () => context.go('/physical_activity_questionnaire'),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: CardActivityWorkWidget(activityWork: _activityWork!),
        ),
      ),
    );
  }
}
