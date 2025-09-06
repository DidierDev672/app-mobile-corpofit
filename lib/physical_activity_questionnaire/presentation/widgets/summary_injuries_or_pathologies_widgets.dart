import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/physical_activity_questionnaire/domain/entities/injuries_or_pathologies.dart';
import 'package:corpofit_mobile/physical_activity_questionnaire/insfrastructure/services/local_Injuries_or_pathology_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SummaryInjuriesOrPathologiesWidget extends StatefulWidget {
  const SummaryInjuriesOrPathologiesWidget({super.key});

  @override
  State<SummaryInjuriesOrPathologiesWidget> createState() =>
      _SummaryInjuriesOrPathologiesWidgetState();
}

class _SummaryInjuriesOrPathologiesWidgetState
    extends State<SummaryInjuriesOrPathologiesWidget> {
  InjuriesOrPathologies? injuriesOrPathologies;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      injuriesOrPathologies = InjuriesOrPathologies(
        beenInjured:
            LocalInjuriesOrPathologyService.read<bool>('been_injured') ?? false,
        indicateInjuryOne: LocalInjuriesOrPathologyService.read<String>(
          'indicate_injury_one',
        ),
        longAgoOne: LocalInjuriesOrPathologyService.read<String>(
          'long_ago_one',
        ),
        treatedMedically:
            LocalInjuriesOrPathologyService.read<bool>('treated_medically') ??
            false,
        indicateInjuryTwo: LocalInjuriesOrPathologyService.read<String>(
          'indicate_injury_two',
        ),
        longAgoTwo: LocalInjuriesOrPathologyService.read<String>(
          'long_ago_two',
        ),
        preventsFromDoing: LocalInjuriesOrPathologyService.read<String>(
          'prevents_from_doing',
        ),
        physicalPainOrDiscomfort:
            LocalInjuriesOrPathologyService.read<bool>(
              'physical_pain_or_discomfort',
            ) ??
            false,
        indicateInjuryThree: LocalInjuriesOrPathologyService.read<String>(
          'indicate_injury_three',
        ),
        longAgoThree: LocalInjuriesOrPathologyService.read<String>(
          'long_ago_three',
        ),
        havePathologies:
            LocalInjuriesOrPathologyService.read<bool>('have_pathologies') ??
            false,
        tratedMedically:
            LocalInjuriesOrPathologyService.read<bool>('trated_medically') ??
            false,
      );
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return Center(
        child: Text(
          'Error al cargar datos',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de lesiones o patologías'),
        leading: IconButton(
          onPressed: () => context.go('/physical_activity_questionnaire'),
          icon: const Icon(Icons.arrow_back),
          color: Colors.blueAccent,
          iconSize: 30,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(25),
          ),
          gradient: LinearGradient(
            colors: [Colors.grey.shade300, Colors.grey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: CardSummaryInjuriesOrPathologiesWidget(
            injuriesOrPathologies: injuriesOrPathologies!,
          ),
        ),
      ),
    );
  }
}

class CardSummaryInjuriesOrPathologiesWidget extends StatelessWidget {
  final InjuriesOrPathologies injuriesOrPathologies;
  const CardSummaryInjuriesOrPathologiesWidget({
    super.key,
    required this.injuriesOrPathologies,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.favorite_rounded,
            size: 35,
            color:
                injuriesOrPathologies.beenInjured
                    ? Colors.deepOrange
                    : Colors.grey,
          ),
          title:
              injuriesOrPathologies.beenInjured
                  ? Text(
                    'Si',
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: size.width * 0.05,
                    ),
                  )
                  : Text(
                    'No',
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: size.width * 0.05,
                    ),
                  ),
          subtitle: Text(
            '¿Alguna vez se ha lesionado?',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        if (injuriesOrPathologies.beenInjured) ...{
          ListTile(
            leading: Icon(
              Icons.style_outlined,
              size: 35,
              color:
                  injuriesOrPathologies.beenInjured
                      ? Colors.orange
                      : Colors.grey,
            ),
            title: Text(
              injuriesOrPathologies.indicateInjuryOne!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Indique la lesión',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(
              Icons.calculate_outlined,
              size: 35,
              color:
                  injuriesOrPathologies.beenInjured
                      ? Colors.orangeAccent
                      : Colors.grey,
            ),
            title: Text(
              injuriesOrPathologies.longAgoOne!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Hace cuánto (meses)?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 10),
        },
        FadeInLeft(
          duration: const Duration(milliseconds: 1000),
          child: Divider(
            color:
                injuriesOrPathologies.beenInjured
                    ? Colors.deepOrange
                    : Colors.grey,
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.warning_rounded,
            size: 35,
            color:
                injuriesOrPathologies.treatedMedically
                    ? Colors.blueAccent
                    : Colors.grey,
          ),
          title: Text(
            injuriesOrPathologies.treatedMedically ? 'Si' : 'No',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Presenta algún dolor o molestia física?',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        if (injuriesOrPathologies.treatedMedically) ...{
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.style_outlined,
              size: 35,
              color:
                  injuriesOrPathologies.treatedMedically
                      ? Colors.lightBlue
                      : Colors.grey,
            ),
            title: Text(
              injuriesOrPathologies.indicateInjuryTwo!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Indique la lesión?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.calculate_outlined,
              size: 35,
              color:
                  injuriesOrPathologies.treatedMedically
                      ? Colors.lightBlueAccent
                      : Colors.grey,
            ),
            title: Text(
              injuriesOrPathologies.longAgoTwo!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Hace cuánto (meses)?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.surfing_outlined,
              size: 35,
              color:
                  injuriesOrPathologies.treatedMedically
                      ? Colors.blueGrey
                      : Colors.grey,
            ),
            title: Text(
              injuriesOrPathologies.preventsFromDoing!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Qué le impide realizer?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        },
        SizedBox(height: 16),
        FadeInLeft(
          duration: const Duration(milliseconds: 1500),
          child: Divider(
            color:
                injuriesOrPathologies.treatedMedically
                    ? Colors.blueAccent
                    : Colors.grey,
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.health_and_safety,
            size: 35,
            color:
                injuriesOrPathologies.physicalPainOrDiscomfort
                    ? Colors.deepOrangeAccent
                    : Colors.grey,
          ),
          title: Text(
            injuriesOrPathologies.physicalPainOrDiscomfort ? 'Si' : 'No',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Tiene alguna patologia?',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        if (injuriesOrPathologies.physicalPainOrDiscomfort) ...{
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.style_rounded,
              size: 35,
              color:
                  injuriesOrPathologies.physicalPainOrDiscomfort
                      ? Colors.redAccent
                      : Colors.grey,
            ),
            title: Text(
              injuriesOrPathologies.indicateInjuryThree!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Indique la lesión',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.calculate_outlined,
              size: 35,
              color:
                  injuriesOrPathologies.physicalPainOrDiscomfort
                      ? Colors.red.shade400
                      : Colors.grey,
            ),
            title: Text(
              injuriesOrPathologies.longAgoThree!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Hace cuánto (meses)?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.medication_liquid,
              size: 35,
              color:
                  injuriesOrPathologies.tratedMedically!
                      ? Colors.red.shade300
                      : Colors.grey,
            ),
            title: Text(
              injuriesOrPathologies.tratedMedically! ? 'Si' : 'No',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Fue tratada médicamente?',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        },
        SizedBox(height: 60),
      ],
    );
  }
}
