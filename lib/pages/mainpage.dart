import 'package:fange/pages/e621page.dart';
import 'package:fange/preferences/preferences.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final Function(Widget) onPageChange;

  const MainPage({super.key, required this.onPageChange});

  @override
  State<MainPage> createState() => _MainPageState(onPageChange);
}

class _MainPageState extends State<MainPage> {
  final Function(Widget) onPageChange;
  Widget? thisPage;

_MainPageState(this.onPageChange);

  @override
  Widget build(BuildContext context) {
      thisPage = Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 20, 192),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: InkWell( 
                onTap: changeToE621Page, 
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: E621Theme.appBarColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: const Center(
                    child: Text(
                      'E621',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20
                      ),
                    ),
                  ),
                )
              ),
            ),
            /*Container(
              padding: const EdgeInsets.all(10),
              child: InkWell( 
                onTap: changeToE621Page, 
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: E621Theme.appBarColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: const Center(
                    child: Text(
                      'E926',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20
                      ),
                    ),
                  ),
                )
              ),
            ),*/
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

    onPageChange(E621Page(apiKey: apiKey, username: username, onCancel: () => { onPageChange(getMainPage())}, onImageSelected: onPageChange, ));
  }
}