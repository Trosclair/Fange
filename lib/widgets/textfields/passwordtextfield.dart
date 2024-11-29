import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController textController;

  const PasswordTextField({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 35,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: textController,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          isDense: true,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 172, 168, 168),
            fontSize: 14
          ),
          hintText: 'API Key',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}