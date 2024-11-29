import 'package:fange/Themes/e926theme.dart';
import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: E926Theme.appBarColor,
    );
  }
}