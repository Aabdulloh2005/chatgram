import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final Icon? prefixIcon;
  final bool? obscureText;
  final bool isBorder;
  final String? errorText;
  final FocusNode? focusNode;

  final Function(String)? onChanged;
  const CustomTextfield({
    super.key,
    this.focusNode,
    this.isBorder = true,
    this.controller,
    this.validator,
    required this.hintText,
    this.prefixIcon,
    this.textInputAction,
    this.obscureText,
    this.onChanged,
    this.errorText,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      maxLines: null,
      onChanged: onChanged,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
        
        contentPadding: const EdgeInsets.only(top: 12),
        errorText: errorText,
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: isBorder ? _returnBorder() : InputBorder.none,
        errorBorder: isBorder ? _returnBorder(Colors.red) : InputBorder.none,
        focusedBorder: isBorder ? _returnBorder() : InputBorder.none,
        enabledBorder: isBorder ? _returnBorder() : InputBorder.none,
      ),
    );
  }
}

OutlineInputBorder _returnBorder([Color? color]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color ?? Colors.grey),
  );
}
