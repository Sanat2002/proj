import 'package:flutter/material.dart';
import 'package:flutter_proj/utils/colors.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: baseColor,
      content: Text(
        message,
        style:const TextStyle(color: Colors.black),
      ),
      duration:const Duration(seconds: 4),
    ),
  );
}