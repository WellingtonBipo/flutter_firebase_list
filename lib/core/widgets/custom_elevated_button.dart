import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/core/custom_colors.dart';

class CustomElevatedButton extends ElevatedButton {
  CustomElevatedButton({
    super.key,
    required String text,
    required super.onPressed,
  }) : super(
          child: Text(text),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: CustomColors.grey,
          ),
        );
}
