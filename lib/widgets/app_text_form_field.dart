import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.labelText,
    this.formFieldKey,
    this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validatorNumber = false,
  });

  final GlobalKey<FormFieldState<String>>? formFieldKey;
  final TextInputType keyboardType;
  final String labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool validatorNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        inputFormatters: inputFormatters,
        maxLines: null,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pole nie może być puste';
          }
          if (validatorNumber == true) {
            double amount = double.parse(value);
            if (amount < 0.01) {
              return 'Kwota musi być większa od 0';
            }
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
              foreground: Paint()
                ..shader = ui.Gradient.linear(
                  const Offset(0, 5),
                  const Offset(25, 5),
                  <Color>[
                    Colors.cyan.shade800,
                    Colors.cyan.shade900,
                  ],
                )),
          hintText: hintText,
        ),
        key: formFieldKey,
        onChanged: onChanged,
      ),
    );
  }
}
