import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/physical_exercise/domain/entities/physical_exercise.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CardPhysicalExerciseWidget extends StatelessWidget {
  final PhysicalExercise physicalExercise;
  const CardPhysicalExerciseWidget({super.key, required this.physicalExercise});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          '¿Realiza o ha realizado ejercico físico?',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: ListTile(
            leading: Icon(
              Icons.sports_hockey_rounded,
              size: size.width * 0.08,
              color:
                  physicalExercise.isExercise!
                      ? Colors.greenAccent
                      : Colors.grey,
            ),
            title: Text(
              physicalExercise.isExercise! ? 'Si' : 'No',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Actualmente hago ejercicio',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Divider(
          color: physicalExercise.isExercise! ? Colors.green : Colors.grey,
          thickness: 2,
        ),
        SizedBox(height: size.height * 0.02),
        FadeInDown(
          duration: const Duration(milliseconds: 800),
          child: ListTile(
            leading: Icon(
              Icons.sports_basketball,
              size: size.width * 0.08,
              color:
                  physicalExercise.notExercise!
                      ? Colors.blueAccent
                      : Colors.grey,
            ),
            title: Text(
              physicalExercise.notExercise! ? 'Si' : 'No',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Actualmente no hago ejercicio',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        if (physicalExercise.notExercise!) ...{
          ListTile(
            leading: Icon(
              Icons.sports_bar_rounded,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalExercise.whatActivity!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Qué actividad realizaba?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalExercise.yearsNotTrained!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Cuántos años no entrenaba?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalExercise.monthsNotTrained!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Cuántos meses no entrenaba?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalExercise.yearsNotBeenTraining!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Cuántos años no entrenaba?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalExercise.monthsNotBeenTraining!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Cuántos meses no entrenaba?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalExercise.monthsNotBeenTraining!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Cuántos meses no entrenaba?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.sports_baseball_rounded,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalExercise.whatIntentionCarryPractice!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Con qué intención realizaba esta práctica?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.sports_gymnastics_outlined,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalExercise.preventedHimFromContinuingPractice!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Qué te impidió continuar esta práctica?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        },
        Divider(
          color: physicalExercise.notExercise! ? Colors.blue : Colors.grey,
          thickness: 2,
        ),
        SizedBox(height: size.height * 0.02),
        FadeInDown(
          duration: const Duration(milliseconds: 1100),
          child: ListTile(
            leading: Icon(
              Icons.sports_bar_outlined,
              size: size.width * 0.08,
              color:
                  physicalExercise.neverExercise!
                      ? Colors.redAccent
                      : Colors.grey,
            ),
            title: Text(
              physicalExercise.neverExercise! ? 'Si' : 'No',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Nunca he hecho ejercicio',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        if (physicalExercise.neverExercise!) ...{
          ListTile(
            leading: Icon(
              Icons.motion_photos_auto_rounded,
              size: 35,
              color: Colors.amber,
            ),
            title: Text(
              physicalExercise.motivatesStartExercising!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Qué te motiva a comenzar a practicar?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        },
        SizedBox(height: size.height * 0.02),
        Divider(
          color:
              physicalExercise.neverExercise! ? Colors.redAccent : Colors.grey,
          thickness: 2,
        ),
        CustomButton(
          label: 'Enviar resumen',
          buttonColor: Colors.blueAccent,
          onPressed: () {},
        ),
      ],
    );
  }
}
