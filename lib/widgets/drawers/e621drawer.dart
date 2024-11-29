import 'package:fange/Themes/e621theme.dart';
import 'package:flutter/material.dart';

class E621Drawer extends StatelessWidget {
  final VoidCallback onLogoutPressed;

  const E621Drawer({super.key, required this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: E621Theme.appBarColor,
      child: Column(
        children: [
          TextButton(onPressed: () => onLogoutButtonPressed(context), child: const Text('Logout', style: TextStyle(color: Colors.red),))
        ],
      ),
    );
  }

  void onLogoutButtonPressed(BuildContext context) {
    Navigator.of(context).pop();
    onLogoutPressed();
  }
}