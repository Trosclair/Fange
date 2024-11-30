import 'package:fange/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:fange/collections/stackcollection.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Widget? currentPage;
  StackCollection<Widget> lastPages = StackCollection();
  TextEditingController textController = TextEditingController();

  _HomePageState() {
    currentPage = MainPage(onPageChange: onPageChange, onBackButtonPressed: onBackButtonPressed);
  }

  @override
  Widget build(BuildContext context) {
    return currentPage ?? const Placeholder();
  }

  void onBackButtonPressed(bool didPop, Object? result) {
    if (lastPages.isNotEmpty) {
      setState(() {
        currentPage = lastPages.pop();
      });
    }
    else {
      SystemNavigator.pop();
    }
  }

  void onPageChange(Widget page) {
    if (currentPage != null) {
      lastPages.push(currentPage!);
    }

    setState(() {
      currentPage = page;
    });
  }
}