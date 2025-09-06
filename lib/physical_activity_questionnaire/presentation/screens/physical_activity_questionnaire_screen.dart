import 'package:corpofit_mobile/utils/widgets/card_utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhysicalActivityQuestionnaireScreen extends StatelessWidget {
  const PhysicalActivityQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ListActivity = <ActivityProperties>[
      ActivityProperties(
        activity: 'LESIONES O PATOLOGÍAS',
        route: '/injuries_or_pathologies',
        color: Colors.blueAccent,
        textColor: Colors.white,
      ),
      ActivityProperties(
        activity: 'ACTIVIDAD LABORAL',
        route: '/activity_work',
        color: Colors.purpleAccent,
        textColor: Colors.white,
      ),
      ActivityProperties(
        activity: 'ACTIVIDAD FÍSICA',
        route: '/sports_activity',
        color: Colors.yellowAccent,
        textColor: Colors.black,
      ),
      ActivityProperties(
        activity: 'TIEMPO LIBRE',
        route: '/leisure',
        color: Colors.orangeAccent,
        textColor: Colors.white,
      ),
      ActivityProperties(
        activity: 'EJERICIO FÍSICO',
        route: '/physical_exercise',
        color: Colors.greenAccent,
        textColor: Colors.black,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Questionario de Actividad Física',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.white60],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: ListActivity.length,
          itemBuilder: (context, index) {
            final activity = ListActivity[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardUtilsWidget(
                  title: activity.activity,
                  color: activity.color,
                  textColor: activity.textColor,
                  route: activity.route,
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ActivityProperties {
  final String activity;
  final String route;
  final Color color;
  final Color textColor;

  ActivityProperties({
    required this.activity,
    required this.route,
    required this.color,
    required this.textColor,
  });
}
