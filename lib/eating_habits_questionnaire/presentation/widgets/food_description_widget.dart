import 'package:flutter/material.dart';

enum MealType {
  meal1('Comida 1', 'Desayuno'),
  meal2('Comida 2', 'Almuerzo'),
  meal3('Comida 3', 'Cena'),
  meal4('Comida 4', 'Merienda');

  const MealType(this.label, this.description);
  final String label;
  final String description;
}

class FoodDescriptionWidget extends StatefulWidget {
  final Function(MealType selectedMeal)? onMealSelected;
  final Function(Map<MealType, String> descriptions)? onDescriptionsChanged;
  final MealType? initialSelectedMeal;
  const FoodDescriptionWidget({
    super.key,
    this.onMealSelected,
    this.onDescriptionsChanged,
    this.initialSelectedMeal,
  });

  @override
  State<FoodDescriptionWidget> createState() => _FoodDescriptionWidgetState();
}

class _FoodDescriptionWidgetState extends State<FoodDescriptionWidget> {
  MealType? _selectedMeal;
  final Map<MealType, TextEditingController> _controllers = {};
  final Map<MealType, String> _descriptions = {};

  @override
  void initState() {
    super.initState();
    _selectedMeal = widget.initialSelectedMeal;

    for (final meal in MealType.values) {
      _controllers[meal] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onMealSelected(MealType? meal) {
    setState(() {
      _selectedMeal = meal;
    });

    if (meal != null) {
      widget.onMealSelected?.call(meal);
    }
  }

  void _onDescriptionChanged(MealType meal, String description) {
    _descriptions[meal] = description;
    widget.onDescriptionsChanged?.call(_descriptions);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Text(
            'Describe los alimentos que consume por comida en un día de alimentación',
            style: textStyle.titleMedium?.copyWith(
              fontSize: size.width * 0.042,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: size.height * 0.03),

        Text(
          'Selecciona la comida que deseas describir:',
          style: textStyle.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return _buildMobileGrid(textStyle, size);
            } else {
              return _buildDesktopRow(textStyle, size);
            }
          },
        ),

        const SizedBox(height: 24),
        if (_selectedMeal != null) ...[
          _buildDescriptionSection(textStyle, size),
        ],
      ],
    );
  }

  Widget _buildMobileGrid(TextTheme textStyle, Size size) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: MealType.values.length,
      itemBuilder: (context, index) {
        final meal = MealType.values[index];
        return _buildMealOption(meal, textStyle, size);
      },
    );
  }

  Widget _buildDesktopRow(TextTheme textStyle, Size size) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          MealType.values
              .map(
                (meal) => SizedBox(
                  width: (size.width - 80) / 4,
                  child: _buildMealOption(meal, textStyle, size),
                ),
              )
              .toList(),
    );
  }

  Widget _buildMealOption(MealType meal, TextTheme textStyle, Size size) {
    final isSelected = _selectedMeal == meal;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
      ),
      child: RadioListTile<MealType>(
        value: meal,
        groupValue: _selectedMeal,
        onChanged: _onMealSelected,
        title: Text(
          meal.label,
          style: textStyle.bodyMedium?.copyWith(
            fontSize: size.width * 0.035,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue.shade800 : Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          meal.description,
          style: textStyle.bodySmall?.copyWith(
            fontSize: size.width * 0.03,
            color: isSelected ? Colors.blue.shade600 : Colors.grey[500],
          ),
          textAlign: TextAlign.center,
        ),
        dense: true,
        activeColor: Colors.blue,
      ),
    );
  }

  Widget _buildDescriptionSection(TextTheme textStyle, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Colors.green.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Descripción de ${_selectedMeal!.description}',
                style: textStyle.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          TextFormField(
            controller: _controllers[_selectedMeal],
            onChanged: (value) => _onDescriptionChanged(_selectedMeal!, value),
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  'Ejemplo: Arepa con queso, café con leche, jugo de naranja natural...',
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: size.width * 0.035,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.green.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.green.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.green.shade600, width: 2),
              ),
              contentPadding: const EdgeInsets.all(12),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, describe los alimentos de esta comida';
              }
              if (value.trim().length < 10) {
                return 'Por favor, proporciona una descripción más detallada';
              }
              return null;
            },
          ),

          const SizedBox(height: 8),

          Text(
            'Tip: Incluye todos los alimentos, bebidas y porciones aproximadas',
            style: textStyle.bodySmall?.copyWith(
              color: Colors.green.shade600,
              fontStyle: FontStyle.italic,
              fontSize: size.width * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
