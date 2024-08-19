import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({super.key, required this.title ,required this.onChanged ,this.obscureText = false,this.keyboardType=TextInputType.text});
  final String title;
  final void Function(String) onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: title,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}