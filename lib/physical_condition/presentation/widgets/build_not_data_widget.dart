import 'package:flutter/material.dart';

class BuildNotDataWidget extends StatelessWidget {
  const BuildNotDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open_outlined,
              size: size.width * 0.15,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'No se encontraron datos',
              style: textStyle.titleLarge?.copyWith(
                fontSize: size.width * 0.05,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'No hay informacióm de antropometría guardada',
              style: textStyle.titleMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
