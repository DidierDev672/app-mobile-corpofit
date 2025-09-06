import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/physical_condition/domain/entities/physical_test_entities.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CardPhysicalTestWidget extends StatelessWidget {
  final PhysicalTestEntities physicalTestEntities;
  const CardPhysicalTestWidget({super.key, required this.physicalTestEntities});

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
              Icons.sports_cricket,
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text(
              physicalTestEntities.activity,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Actvidad',
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
              size: 35,
              color: Colors.blue.shade600,
            ),
            title: Text(
              physicalTestEntities.result.toString(),
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              physicalTestEntities.resultEnum,
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
              Icons.roller_skating_outlined,
              size: 35,
              color: Colors.blue.shade500,
            ),
            title: Text(
              physicalTestEntities.classification,
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
          child: Divider(color: Colors.blue.shade500),
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          width: 250,
          height: 65,
          child: CustomButton(
            buttonColor: Colors.blueAccent,
            textColor: Colors.white,
            label: 'Enviar resumen',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
