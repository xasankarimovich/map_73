import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  const NumberField({super.key, required this.controller, required this.text});
  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: TextField(
        keyboardType: TextInputType.number,
        maxLength: 5,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow, width: 2),
          ),
        ),
      ),
    );
  }
}
