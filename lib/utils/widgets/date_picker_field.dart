import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const DatePickerField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (selectedDate != null) {
          widget.controller.text = DateFormat(
            'yyyy-MM-dd',
          ).format(selectedDate);
          if (widget.validator != null) {
            widget.validator!(widget.controller.text);
          }
          setState(() {});
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: AbsorbPointer(
          absorbing: true,
          ignoringSemantics: true,
          child: TextFormField(
            style: const TextStyle(color: Colors.black),

            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.label,
              suffixIcon: const Icon(Icons.calendar_today),
              border: const OutlineInputBorder(),
            ),
            validator: widget.validator,
            readOnly: true, // Evita que el teclado aparezca
          ),
        ),
      ),
    );
  }
}
