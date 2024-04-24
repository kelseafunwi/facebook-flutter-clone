import "package:flutter/material.dart";

class RoundTextField extends StatelessWidget {
  const RoundTextField({
    super.key, required this.controller, required this.hintText, this.isPassword = false, this.keyboardType = TextInputType.name, required this.textInputAction, this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  // validator is a function that will optionally take in a string and optionally return another string.
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10)
          )
        )
      ),
      obscureText: isPassword,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
    );
  }
}
