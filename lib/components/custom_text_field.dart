import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.validator,
      this.maxLines = 1});

  final String label;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontFamily: 'Quicksand',
              color: Colors.orange,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.orange, width: 1),
            )),
      ),
    );
  }
}
