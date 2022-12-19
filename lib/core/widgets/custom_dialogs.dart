import 'package:flutter/material.dart';

abstract class CustomDialogs {
  static void showLoading(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
            child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        )),
      );

  static void showBottonWarning(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text)),
      );
}
