import 'package:flutter/material.dart';

class CustomTextFormField extends TextFormField {
  CustomTextFormField({
    super.key,
    super.controller,
    String? label,
    String? hintText,
  }) : super(
            decoration: InputDecoration(
          label: label == null
              ? null
              : Text(label, style: const TextStyle(color: Colors.white)),
          hintText: hintText,
        ));
}
