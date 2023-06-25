// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  const CustomTextForm({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        
      ),
      controller: controller,
      obscureText: obscureText,
      
    );
  }
}
