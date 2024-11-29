import 'package:fange/pages/e621page.dart';
import 'package:fange/preferences/preferences.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:fange/widgets/buttons/boorusitetile.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final Function(Widget) onPageChange;

  const MainPage({super.key, required this.onPageChange});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget? thisPage;

_MainPageState();

  @override
  Widget build(BuildContext context) {
      thisPage = Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 20, 192),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            BooruSiteTile(changeToPage: changeToE621Page, tileBackground: E621Theme.appBarColor, urlOfIcon: 'assets/images/e621.net.png'),
            BooruSiteTile(changeToPage: changeToSafeBooruPage, tileBackground: E621Theme.appBarColor, urlOfIcon: 'assets/images/safebooru.org.png'),
          ],
        ),
      ),
    );

    return getMainPage();
  }

  Widget getMainPage() => thisPage ?? const Placeholder();

  void changeToE621Page() async {
    String apiKey = await Preferences.getE621APIKey() ?? '';
    String username = await Preferences.getE621Username() ?? '';

    widget.onPageChange(E621Page(apiKey: apiKey, username: username, onCancel: () => { widget.onPageChange(getMainPage())}, onImageSelected: widget.onPageChange, ));
  }

  void changeToSafeBooruPage() {

  }
}