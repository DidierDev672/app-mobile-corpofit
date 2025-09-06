import 'package:corpofit_mobile/sports_activity/domain/entities/sports_activity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../infrastructure/infrastructure.dart';
import '../widgets/widgets.dart';

class SummarySportsActivityScreen extends StatefulWidget {
  const SummarySportsActivityScreen({super.key});

  @override
  State<SummarySportsActivityScreen> createState() =>
      _SummarySportsActivityScreenState();
}

class _SummarySportsActivityScreenState
    extends State<SummarySportsActivityScreen> {
  SportsActivity? sportsActivity;

  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _hasError = false;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      sportsActivity = SportsActivity(
        playAnySport:
            LocalSportsActivityService.read('play_any_sport') ?? false,
        whichSport: LocalSportsActivityService.read('which_sport') ?? '',
        indicateAnnoyance:
            LocalSportsActivityService.read('indicate_annoyance') ?? '',
        dayWeek: int.parse(LocalSportsActivityService.read('day_week') ?? '0'),
        timeDay: int.parse(LocalSportsActivityService.read('time_day') ?? '0'),
        year: int.parse(LocalSportsActivityService.read('year') ?? '0'),
        month: int.parse(LocalSportsActivityService.read('month') ?? '0'),
        sportsCreation:
            LocalSportsActivityService.read('sports_creation') ?? false,
        sportsTraining:
            LocalSportsActivityService.read('sports_training') ?? false,
        professionalPreparation:
            LocalSportsActivityService.read('professional_preparation') ??
            false,
        aestheticResult:
            LocalSportsActivityService.read('aesthetic_result') ?? false,
        healthyState: LocalSportsActivityService.read('healthy_state') ?? false,
        practiceCauseDiscomfort:
            LocalSportsActivityService.read('practice_cause_discomfort') ??
            false,
        which: LocalSportsActivityService.read('which') ?? '',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
      debugPrint(e.toString());
      setState(() {
        _hasError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return const Center(child: Text('Error al cargar los datos'));
    }

    if (sportsActivity == null) {
      return const Center(child: Text('No hay datos'));
    }

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resumen de actividad física',
          style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.orangeAccent,
            size: 35,
          ),
          onPressed: () => context.go('/physical_activity_questionnaire'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(15),
              ),
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white70],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: CardSummarySportsActivityWidget(
              sportsActivity: sportsActivity!,
            ),
          ),
        ),
      ),
    );
  }
}
