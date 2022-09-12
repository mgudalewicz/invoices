import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.formFieldKey,
    required this.labelText,
    this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

  final GlobalKey<FormFieldState<String>>? formFieldKey;
  final TextInputType keyboardType;
  final String labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

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
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
        key: formFieldKey,
        onChanged: onChanged,
      ),
    );
  }
}
