import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class CardClinialScreeningWidget extends StatelessWidget {
  final ClinicalScreeningEntity clinicalScreening;
  const CardClinialScreeningWidget({
    super.key,
    required this.clinicalScreening,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 700),
          child: ListTile(
            leading: Icon(
              Icons.fitness_center_outlined,
              size: 34,
              color: Colors.blueAccent,
            ),
            title: Text(
              clinicalScreening.activity,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Actividad',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInLeft(
          duration: const Duration(milliseconds: 900),
          child: Divider(color: Colors.blueAccent),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInDown(
          duration: const Duration(milliseconds: 1100),
          child: ListTile(
            leading: Icon(
              Icons.bookmark_add_outlined,
              size: 34,
              color: Colors.blue.shade600,
            ),
            title: Text(
              clinicalScreening.result.toString(),
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Resultado: ${clinicalScreening.resultEnum}',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInLeft(
          duration: const Duration(milliseconds: 1300),
          child: Divider(color: Colors.blue.shade600),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInDown(
          duration: const Duration(milliseconds: 1500),
          child: ListTile(
            leading: Icon(
              Icons.bookmark_added_sharp,
              size: 35,
              color: Colors.blue.shade400,
            ),
            title: Text(
              clinicalScreening.classification,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Clasificación',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInLeft(
          duration: const Duration(milliseconds: 1700),
          child: Divider(color: Colors.blue.shade400),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInDown(
          duration: const Duration(milliseconds: 1900),
          child: SizedBox(
            width: 250,
            height: 65,
            child: CustomButton(
              buttonColor: Colors.blueAccent,
              textColor: Colors.white,
              label: 'Enviar resumen',
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
