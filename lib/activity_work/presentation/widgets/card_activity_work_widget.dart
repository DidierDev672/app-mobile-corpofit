import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/activity_work/domain/entities/activity_work.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CardActivityWorkWidget extends StatelessWidget {
  final ActivityWork activityWork;
  const CardActivityWorkWidget({super.key, required this.activityWork});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 10),
        ListTile(
          leading: Icon(
            Icons.local_post_office_rounded,
            size: 35,
            color: Colors.deepPurple,
          ),
          title: Text(
            activityWork.doForWork,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿En qué desempeña laboralmente?',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: Divider(color: Colors.deepPurple),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.lock_clock_outlined,
            size: 35,
            color: Colors.deepPurpleAccent,
          ),
          title: Text(
            activityWork.hoursSpendWorking,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Cuántas horas diarias dedica a su trabajo?',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        FadeInLeft(
          duration: const Duration(milliseconds: 1000),
          child: Divider(color: Colors.deepPurpleAccent),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(Icons.punch_clock, size: 35, color: Colors.purple),
          title: Text(
            activityWork.averageHourSitting,
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            'Promedio de horas de pie',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        FadeInLeft(
          duration: const Duration(milliseconds: 1500),
          child: Divider(color: Colors.purple),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(
            Icons.local_activity_rounded,
            size: 35,
            color: Colors.purpleAccent,
          ),
          title: Text(
            activityWork.activityRepresentPainDiscomfort ? 'Si' : 'No',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Su actividad laboral representa algún dolor o molestia?',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        FadeInLeft(
          duration: const Duration(milliseconds: 2000),
          child: Divider(color: Colors.purpleAccent),
        ),
        SizedBox(height: 16),
        if (activityWork.activityRepresentPainDiscomfort) ...{
          FadeInDown(
            child: ListTile(
              leading: Icon(
                Icons.pending_actions_sharp,
                size: 35,
                color: Colors.indigoAccent,
              ),
              title: Text(
                activityWork.which!,
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
              subtitle: Text(
                '¿Cuál?',
                style: textStyle.titleSmall?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
          ),
          FadeInLeft(
            duration: const Duration(milliseconds: 2500),
            child: Divider(color: Colors.indigoAccent),
          ),
          SizedBox(height: 16),
        },
        CustomButton(
          label: 'Enviar el resume',
          buttonColor: Colors.purple,
          onPressed: () {},
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
