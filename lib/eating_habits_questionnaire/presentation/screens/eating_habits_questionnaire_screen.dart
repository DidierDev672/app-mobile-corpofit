import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/utils/widgets/custom_switch.dart';
import 'package:corpofit_mobile/utils/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/widgets.dart';

class EatingHabitsQuestionnaireScreen extends StatefulWidget {
  const EatingHabitsQuestionnaireScreen({super.key});

  @override
  State<EatingHabitsQuestionnaireScreen> createState() =>
      _EatingHabitsQuestionnaireScreenState();
}

enum MealsPerDay {
  one('1', 1),
  two('2', 2),
  three('3', 3),
  four('4', 4),
  five('5', 5);

  const MealsPerDay(this.display, this.value);
  final String display;
  final int value;
}

class _EatingHabitsQuestionnaireScreenState
    extends State<EatingHabitsQuestionnaireScreen> {
  MealsPerDay? _selectedMealsPerDay;
  bool _isLoading = false;
  bool _isDisposed = false;

  Map<MealType, String> _descriptions = {};
  MealType? _selectedMeal;

  bool _isAllergies = false;
  bool _isIntolerant = false;
  bool _isResult = false;

  @override
  void initState() {
    super.initState();
  }

  final List<String> layer = [
    'Ninguna',
    'Colón irritable',
    'Diabetes tipo 1',
    'Diabetes tipo 2',
    'Gastritis',
    'Colesterol alto',
    'Reflujo Gástrico',
    'Hiperglucemia',
  ];

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _safeSetState(VoidCallback fn) {
    if (!_isDisposed && mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cuestionario de habitos alimenticios',
          style: textStyle.titleLarge?.copyWith(fontSize: size.width * 0.045),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.orangeAccent,
            size: 28,
          ),
          onPressed: _isLoading ? null : () => context.go('/home'),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white70, Color(0XFFF8F9FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(15),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildQuestionTitle(textStyle, size),
              SizedBox(height: size.height * 0.03),
              _buildMealsSelection(textStyle, size),
              SizedBox(height: size.height * 0.03),
              FoodDescriptionWidget(
                onMealSelected: (meal) {
                  _safeSetState(() {
                    _selectedMeal = meal;
                  });
                },
                onDescriptionsChanged: (descriptions) {
                  _safeSetState(() {
                    _descriptions = descriptions;
                  });
                },
                initialSelectedMeal: _selectedMeal,
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Señele dónde son preparadas sus comidas',
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.042,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadioMenuButton(
                    value: null,
                    groupValue: null,
                    onChanged: null,
                    child: Text(
                      'En casa',
                      style: textStyle.titleSmall?.copyWith(
                        fontSize: size.width * 0.042,
                      ),
                    ),
                  ),
                  RadioMenuButton(
                    value: null,
                    groupValue: null,
                    onChanged: null,
                    child: Text(
                      'Fuera de casa',
                      style: textStyle.titleSmall?.copyWith(
                        fontSize: size.width * 0.042,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '¿Es alérgico a algún alimento?',
                      style: textStyle.titleMedium?.copyWith(
                        fontSize: size.width * 0.042,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  CustomSwitch(
                    value: _isAllergies,
                    activeColor: Colors.blueAccent,
                    activeTrackColor: Colors.blue,
                    onChanged: (value) {
                      _safeSetState(() {
                        _isAllergies = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              if (_isAllergies) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 300),
                  child: CustomInput(
                    label: '¿Cual?',
                    hint: 'Alimento al que es alérgico',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, ingresa el alimento al que es alérgico';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              },
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '¿Es intolerante a algún alimento?',
                          style: textStyle.titleMedium?.copyWith(
                            fontSize: size.width * 0.042,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '¿Incluya lácteos y sus derivados, frutas, verduras,leguminosas, frutos secos, etc...?',
                          style: textStyle.bodySmall?.copyWith(
                            fontSize: size.width * 0.035,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSwitch(
                    value: _isIntolerant,
                    activeColor: Colors.blueAccent,
                    activeTrackColor: Colors.blue,
                    onChanged: (value) {
                      _safeSetState(() {
                        _isIntolerant = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              if (_isIntolerant) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 300),
                  child: CustomInput(
                    label: '¿Cual?',
                    hint: 'Alimento al que es intolerante',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, ingresa el alimento al que es intolerante';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              },
              Text(
                'Sobre su alimentación actual',
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.042,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              RadioListTile(
                value: null,
                groupValue: false,
                title: Text(
                  'Es guiado por un profesional del área',
                  style: textStyle.titleSmall?.copyWith(
                    fontSize: size.width * 0.042,
                  ),
                ),
                onChanged: (value) {},
              ),
              RadioListTile(
                value: null,
                groupValue: false,
                title: Text(
                  'Es guiado según su propio criterio',
                  style: textStyle.titleSmall?.copyWith(
                    fontSize: size.width * 0.042,
                  ),
                ),
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Esta alimentación es',
                        style: textStyle.bodyMedium?.copyWith(
                          fontSize: size.width * 0.042,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        'Alta',
                        style: textStyle.titleSmall?.copyWith(
                          fontSize: size.width * 0.042,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        'Baja',
                        style: textStyle.titleSmall?.copyWith(
                          fontSize: size.width * 0.042,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        'Sin',
                        style: textStyle.titleSmall?.copyWith(
                          fontSize: size.width * 0.042,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Carbohidratos',
                        style: textStyle.bodySmall?.copyWith(
                          fontSize: size.width * 0.043,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Proteínas',
                        style: textStyle.bodySmall?.copyWith(
                          fontSize: size.width * 0.042,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Grasas',
                        style: textStyle.bodySmall?.copyWith(
                          fontSize: size.width * 0.042,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                    SizedBox(width: size.width * 0.08),
                    Radio(value: null, groupValue: null, onChanged: (value) {}),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '¿Obtuvo resultado con ella?',
                        style: textStyle.bodyMedium?.copyWith(
                          fontSize: size.width * 0.043,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    CustomSwitch(
                      value: _isResult,
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _isResult = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              if (_isResult) ...{
                FadeInDown(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    'Los resultados fueron medidos teniendo en cuenta',
                    style: textStyle.bodyMedium?.copyWith(
                      fontSize: size.width * 0.043,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Composición corporal',
                          style: textStyle.bodyMedium?.copyWith(
                            fontSize: size.width * 0.043,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      CustomSwitch(
                        value: false,
                        activeColor: Colors.blueAccent,
                        inactiveThumbColor: Colors.blue,
                        onChanged: (value) {},
                      ),
                      // PopupMenuButton<String>(
                      //   onSelected: (String result) {
                      //     print(result);
                      //   },
                      //   icon: Icon(Icons.more_vert),
                      //   iconColor: Colors.grey,
                      //   itemBuilder:
                      //       (BuildContext context) =>
                      //           layer
                      //               .map(
                      //                 (e) => PopupMenuItem(
                      //                   value: e,
                      //                   child: Text(e),
                      //                 ),
                      //               )
                      //               .toList(),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                FadeInDown(
                  duration: const Duration(milliseconds: 700),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Peso corporal',
                          style: textStyle.bodyMedium?.copyWith(
                            fontSize: size.width * 0.043,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      CustomSwitch(
                        value: false,
                        activeColor: Colors.blueAccent,
                        inactiveThumbColor: Colors.blue,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  '¿Consume licor?',
                  style: textStyle.titleMedium?.copyWith(
                    fontSize: size.width * 0.05,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Nunca',
                        style: textStyle.bodyMedium?.copyWith(
                          fontSize: size.width * 0.043,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    CustomSwitch(
                      value: false,
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blue,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Una vez a la semana',
                        style: textStyle.bodyMedium?.copyWith(
                          fontSize: size.width * 0.043,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    CustomSwitch(
                      value: false,
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blue,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Una vez al mes',
                        style: textStyle.bodyMedium?.copyWith(
                          fontSize: size.width * 0.043,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    CustomSwitch(
                      value: false,
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blue,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Dos o tres veces por semana',
                        style: textStyle.bodyMedium?.copyWith(
                          fontSize: size.width * 0.043,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    CustomSwitch(
                      value: false,
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blue,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Más de tres veces por semana',
                        style: textStyle.bodyMedium?.copyWith(
                          fontSize: size.width * 0.043,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    CustomSwitch(
                      value: false,
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blue,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTitle(TextTheme textStyle, Size size) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Text(
        '¿Cuántas veces come al día?\n\nComidas no refinadas que no sean mecatos, fritos ni chatarra',
        style: textStyle.titleMedium?.copyWith(
          fontSize: size.width * 0.042,
          fontWeight: FontWeight.bold,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMealsSelection(TextTheme textStyle, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecciona una opción:',
          style: textStyle.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 16),

        // Grid de opciones más organizado para móvil
        if (size.width < 600) ...[
          _buildMobileRadioGrid(textStyle, size),
        ] else ...[
          _buildDesktopRadioRow(textStyle, size),
        ],
      ],
    );
  }

  Widget _buildMobileRadioGrid(TextTheme textStyle, Size size) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: MealsPerDay.values.length,
      itemBuilder: (context, index) {
        final meal = MealsPerDay.values[index];
        return _buildRadioOption(meal, textStyle, size);
      },
    );
  }

  Widget _buildDesktopRadioRow(TextTheme textStyle, Size size) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          MealsPerDay.values
              .map(
                (meal) => SizedBox(
                  width: (size.width - 80) / 5,
                  child: _buildRadioOption(meal, textStyle, size),
                ),
              )
              .toList(),
    );
  }

  Widget _buildRadioOption(MealsPerDay meal, TextTheme textStyle, Size size) {
    final isSelected = _selectedMealsPerDay == meal;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.orange : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : null,
      ),
      child: RadioListTile<MealsPerDay>(
        value: meal,
        groupValue: _selectedMealsPerDay,
        onChanged:
            _isLoading
                ? null
                : (MealsPerDay? value) {
                  _safeSetState(() {
                    _selectedMealsPerDay = value;
                  });
                },
        title: Text(
          meal.display,
          style: textStyle.bodyLarge?.copyWith(
            fontSize: size.width * 0.045,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.orange.shade800 : Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        dense: true,
        activeColor: Colors.orange,
      ),
    );
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: isError ? 3 : 2),
      ),
    );
  }
}
