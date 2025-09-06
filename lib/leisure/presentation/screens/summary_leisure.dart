import 'package:corpofit_mobile/leisure/leisure.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/domain.dart';
import '../widgets/widgets.dart';

class SummaryLeisureScreen extends StatefulWidget {
  const SummaryLeisureScreen({super.key});

  @override
  State<SummaryLeisureScreen> createState() => _SummaryLeisureScreenState();
}

class _SummaryLeisureScreenState extends State<SummaryLeisureScreen> {
  Leisure? leisure;

  bool _isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _loadLeisure();
  }

  Future<void> _loadLeisure() async {
    setState(() {
      _isLoading = true;
      isError = false;
    });

    try {
      leisure = Leisure(
        activity: LocalLeisureService.read('activity'),
        manyDaysWeek: LocalLeisureService.read('manyDaysWeek'),
        timePerDay: LocalLeisureService.read('timePerDay'),
        sleepHours: LocalLeisureService.read('sleepHours'),
        sleepMinutes: LocalLeisureService.read('sleepMinutes'),
        formatSleep: LocalLeisureService.read('formatSleep') ?? TimeFormat.AM,
        recoveredOrRested: LocalLeisureService.read('recoveredOrRested'),
        timeToGetUp: LocalLeisureService.read('timeToGetUp'),
        minutesAfterGettingUp: LocalLeisureService.read(
          'minutesAfterGettingUp',
        ),
        formatTimeToGetUp:
            LocalLeisureService.read('formatTimeToGetUp') ?? TimeFormat.AM,
        bedtime: LocalLeisureService.read('bedtime'),
        minuteToSleep: LocalLeisureService.read('minuteToSleep'),
        formatBedtime:
            LocalLeisureService.read('formatBedtime') ?? TimeFormat.AM,
      );
    } catch (e) {
      setState(() {
        isError = true;
        leisure = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
        isError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(child: Text('Error al cargar el resumen'));
    }

    if (leisure == null) {
      return const Center(child: Text('No hay datos para mostrar'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen tiempo libre', style: textStyle.titleLarge),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
            color: Colors.amberAccent,
          ),
          onPressed: () {
            context.go('/physical_activity_questionnaire');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(15),
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
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: CardSummaryLeisure(leisure: leisure!),
        ),
      ),
    );
  }
}
