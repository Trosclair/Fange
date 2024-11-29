import 'package:fange/pages/mainpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? currentPage;
  TextEditingController textController = TextEditingController();

  _HomePageState() {
    currentPage = MainPage(onPageChange: onPageChange);
  }

  @override
  Widget build(BuildContext context) {
    return currentPage ?? const Placeholder();
  }

  void onPageChange(Widget page) {
    setState(() {
      currentPage = page;
    });
  }
}