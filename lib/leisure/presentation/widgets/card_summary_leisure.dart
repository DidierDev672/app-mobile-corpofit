import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class CardSummaryLeisure extends StatelessWidget {
  final Leisure leisure;
  const CardSummaryLeisure({super.key, required this.leisure});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          '¿En su tiempo libre qué actividades realiza?',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.sports_bar_outlined,
            size: 35,
            color: Colors.orange,
          ),
          title: Text(
            leisure.activity,
            style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            'Actividad',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.calendar_month_outlined,
            size: 35,
            color: Colors.orangeAccent,
          ),
          title: Text(
            leisure.manyDaysWeek,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Cuántos días a la semana?',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.lock_clock_outlined,
            size: 35,
            color: Colors.deepOrange,
          ),
          title: Text(
            leisure.timePerDay,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Cuánto tiempo por día (Horas)?',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: 10),
        Divider(color: Colors.orange),
        SizedBox(height: 16),
        Text(
          '¿Siente que su descanso es reparador o se levanta cansado?',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.sledding_outlined,
            size: 35,
            color: Colors.purple,
          ),
          title: Text(
            leisure.recoveredOrRested,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: 16),
        Divider(color: Colors.purpleAccent),
        SizedBox(height: 16),
        Text(
          '¿Generalmente a qué hora se levanta y a qué hora se acuesta?',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        SizedBox(height: 10),
        Text(
          'Hora de levantarse',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.punch_clock_outlined,
            size: 35,
            color: Colors.amber,
          ),
          title: Text(
            leisure.timeToGetUp,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            'Hora de levantarse',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.punch_clock_sharp,
            size: 35,
            color: Colors.amberAccent,
          ),
          title: Text(
            leisure.minutesAfterGettingUp,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            'Minutos',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: 16),
        Divider(color: Colors.amber),
        SizedBox(height: 16),
        Text(
          'Hora de dormir',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(Icons.bed_rounded, size: 35, color: Colors.deepOrange),
          title: Text(
            leisure.bedtime,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            'Horas',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.bedroom_baby,
            size: 35,
            color: Colors.deepOrangeAccent,
          ),
          title: Text(
            leisure.minuteToSleep,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            'Minutos',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: 16),
        CustomButton(label: 'Enviar el resumen', onPressed: () {}),
      ],
    );
  }
}
