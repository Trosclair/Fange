import 'package:e621/e621.dart';
import 'package:fange/pages/e621LoginPage.dart';
import 'package:fange/pages/e621gallerypage.dart';
import 'package:fange/preferences/preferences.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:fange/widgets/buttons/boorusitetile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 20, 192),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            BooruSiteTile(changeToPage: () => changeToE621Page(context), tileBackground: E621Theme.appBarColor, urlOfIcon: 'assets/images/e621.net.png'),
            BooruSiteTile(changeToPage: changeToSafeBooruPage, tileBackground: E621Theme.appBarColor, urlOfIcon: 'assets/images/safebooru.org.png'),
          ],
        ),
      ),
    );
  }

  void changeToE621Page(BuildContext context) async {
    String apiKey = await Preferences.getE621APIKey() ?? '';
    String username = await Preferences.getE621Username() ?? '';
    Widget page;

    if (apiKey.isNotEmpty && username.isNotEmpty) {
      (E621Client?, String) clientTuple = await E621LoginPage.tryLogin(username, apiKey);
      E621Client? client = clientTuple.$1;

      if (client != null) {
        page = E621GalleryPage(client: client);
      }
      else {
        page = E621LoginPage(apiKey: apiKey, username: username);
      }
    }
    else {
      page = E621LoginPage(apiKey: apiKey, username: username);
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void changeToSafeBooruPage() {

  }
}