import 'package:flutter/material.dart';

class UsernameTextField extends StatelessWidget {
  final TextEditingController textController;

  const UsernameTextField({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 35,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: textController,
        decoration: InputDecoration(
          isDense: true,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 172, 168, 168),
            fontSize: 14
          ),
          hintText: 'Username',
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