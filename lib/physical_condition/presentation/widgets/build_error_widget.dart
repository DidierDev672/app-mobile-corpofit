import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildErrorWidget extends StatelessWidget {
  final String errorMessage;
  const BuildErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: size.width * 0.15,
              color: Colors.red.shade400,
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Error al cargar la antropometría',
              style: textStyle.titleLarge?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              errorMessage.isNotEmpty
                  ? errorMessage
                  : 'Error al cargar la antropometría',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                context.go('/physical_condition');
              },
              child: Text(
                'Volver',
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
