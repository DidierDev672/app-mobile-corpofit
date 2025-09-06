import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/physical_condition/domain/entities/screen_entities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhysicalConditionScreen extends StatefulWidget {
  const PhysicalConditionScreen({super.key});

  @override
  State<PhysicalConditionScreen> createState() =>
      _PhysicalConditionScreenState();
}

class _PhysicalConditionScreenState extends State<PhysicalConditionScreen> {
  List<ScreenEntities> screens = [
    ScreenEntities(
      title: 'PRUEBA FÍSICAS',
      color: Colors.blue,
      router: '/physical_test',
    ),
    ScreenEntities(
      title: 'ANTROPOMETRÍA',
      color: Colors.green,
      router: '/anthropometry',
    ),
    ScreenEntities(
      title: 'TAMIZAJE CLÍNICO',
      color: Colors.red,
      router: '/clinical_screening',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Condiciones Fisicas',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.05),
        ),
        leading: InkWell(
          onTap: () {
            context.go('/');
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.arrow_back, size: 20),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            spacing: 10,
            children: [
              ...screens.map(
                (screen) => GestureDetector(
                  onTap: () {
                    context.go(screen.router);
                  },
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 700),
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.1,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [screen.color, screen.color.withOpacity(0.5)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          screen.title,
                          style: textStyle.titleLarge?.copyWith(
                            fontSize: size.width * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
