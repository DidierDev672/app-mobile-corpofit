import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class CardSummaryAnthropometryWidget extends StatelessWidget {
  final AnthropometryEntity anthropometryEntity;
  const CardSummaryAnthropometryWidget({
    super.key,
    required this.anthropometryEntity,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: ListTile(
            leading: Icon(
              Icons.sports_basketball,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              anthropometryEntity.activity,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        FadeInLeft(
          duration: const Duration(milliseconds: 700),
          child: Divider(color: Colors.blueAccent),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInRight(
          duration: const Duration(milliseconds: 900),
          child: Text(
            'Resultado',
            style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        FadeInDown(
          duration: const Duration(milliseconds: 1100),
          child: ListTile(
            leading: Icon(
              Icons.pause_presentation,
              size: 35,
              color: Colors.blue.shade600,
            ),
            title: Text(
              anthropometryEntity.result.toString(),
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              anthropometryEntity.resultEnum,
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        FadeInLeft(
          duration: const Duration(milliseconds: 1400),
          child: Divider(color: Colors.blue.shade500),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInRight(
          duration: const Duration(milliseconds: 1600),
          child: Text(
            'Calificación',
            style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        FadeInDown(
          duration: const Duration(milliseconds: 1800),
          child: ListTile(
            leading: Icon(
              Icons.cabin_outlined,
              size: 35,
              color: Colors.blue.shade400,
            ),
            title: Text(
              anthropometryEntity.clasificationEnum,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
        FadeInLeft(
          duration: const Duration(milliseconds: 2000),
          child: Divider(color: Colors.blue.shade500),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInRight(
          duration: const Duration(milliseconds: 2200),
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
