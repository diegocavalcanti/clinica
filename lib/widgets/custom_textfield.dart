import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? icon;
  final String? initialValue;
  final bool obscureText;
  final String? Function(String? text)? onValidator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hint,
    this.icon,
    this.obscureText = false,
    this.onChanged,
    this.onValidator,
    this.onSaved,
    this.initialValue,
  }) : super(key: key);

  //const CustomField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: onValidator,
      onChanged: onChanged,
      onSaved: onSaved,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
        prefixIcon: icon == null ? null : Icon(icon),
      ),
      autofocus: true,
    );
    ;
  }
}
