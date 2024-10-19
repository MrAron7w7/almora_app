import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? Function(String?)? validator;
  final bool? showPassword;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? icon;
  final TextInputType keyboardType;

  const CustomInput({
    super.key,
    this.validator,
    this.labelText = '',
    this.controller,
    this.icon,
    required this.keyboardType,
    this.showPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: showPassword ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: labelText,
        suffixIcon: icon,
        enabled: true,
      ),
    );
  }
}
