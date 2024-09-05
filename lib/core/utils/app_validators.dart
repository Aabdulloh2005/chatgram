import 'package:flutter/material.dart';

String?   confirmPasswordValidator(
    String? value, TextEditingController passwordController) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != passwordController.text) {
    return 'Passwords do not match';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}
