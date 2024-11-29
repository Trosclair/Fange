import 'package:e621/e621.dart';
import 'package:fange/preferences/preferences.dart';
import 'package:fange/widgets/appbars/e621appbar.dart';
import 'package:fange/widgets/buttons/postpreviewbutton.dart';
import 'package:fange/widgets/drawers/e621drawer.dart';
import 'package:http/http.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:fange/widgets/textfields/passwordtextfield.dart';
import 'package:fange/widgets/textfields/usernametextfield.dart';
import 'package:flutter/material.dart';

class E621Page extends StatefulWidget {
  final String? apiKey;
  final String? username;
  final VoidCallback onCancel;
  final Function(Widget) onImageSelected;

  const E621Page({super.key, required this.apiKey, required this.username, required this.onCancel, required this.onImageSelected});

  @override
  State<E621Page> createState() => _E621PageState();
}

class _E621PageState extends State<E621Page> {

  E621Client? client;
  int pageNumber = 1;

  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController apiKeyTextController = TextEditingController();
  final TextEditingController searchTextController = TextEditingController();

  String loginMessage = '';
  String scrollingError = '';
  Widget? gallery;

  bool firstRun = true;

  List<Widget> postWidgets = <Widget>[]; 
  
  @override
  Widget build(BuildContext context) { 
    if (firstRun) { // run once 
      String? username = widget.username;
      String? apiKey = widget.apiKey;

      if (username != null && apiKey != null) {
        client = E621Client(host: Uri.parse('https://e621.net'), login: username, apiKey: apiKey, userAgent: 'Fange/1.0 (by deadi9 on e621)');
      }
      firstRun = false;
    }

    if (client != null) {
      return gallery ??= getGallery();
    }
    else {
      return Scaffold(
        backgroundColor: E621Theme.appBarColor,
        body: Row (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('E621', style: TextStyle(color: Colors.white)),
                SizedBox(height: 30, child: Text(loginMessage, style: const TextStyle(color: Colors.red))),
                UsernameTextField(textController: usernameTextController),
                const SizedBox(height: 10),
                PasswordTextField(textController: apiKeyTextController),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(onPressed: () => widget.onCancel, style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.yellow)), child: const Text('Cancel')),
                    const SizedBox(width: 10),
                    TextButton(onPressed: onLogin, style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.yellow)), child: const Text('Login'))
                  ],
                )
              ],
            ),
          ]
        ),
      );
    }
  }

  Widget getGallery() {
    return Scaffold(
      backgroundColor: E621Theme.appBarColor,
      appBar: E621AppBar(onHomePressed: widget.onCancel, textController: searchTextController, onSearchPressed: onSearchPressed),
      endDrawer: E621Drawer(onLogoutPressed: onLogout),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: postWidgets,
        ),
      ),
    );
  }

  void onSearchPressed() async {
    postWidgets.clear();
    gallery = null;

    if (searchTextController.text.isNotEmpty) {
      List<String> tags = searchTextController.text.split(' ');
      List<Post>? posts;

      try {
        posts = await client?.posts.list(limit: 320, tags: tags, page: pageNumber);
      } on ClientException catch (e) {
        scrollingError = e.message;
        return;
      } on E621Exception catch (e) {
        setState(() {
          switch (e.statusCode) {
            case 401:
              client = null;
            default:
              scrollingError = '${e.message} Error Code: ${e.statusCode}';
          }
        });
        return;
      }

      List<Widget> tempPostWidgets = <Widget>[];
      if (posts != null) { /// Parallelize this later??
        for (Post x in posts.where((y) => y.preview.url != null)) {
          tempPostWidgets.add(postToWidget(x));
        }
      }

      setState(() {
        postWidgets.addAll(tempPostWidgets);
      });
    }
  }

  Widget postToWidget(Post x) {
    return PostPreviewButton(post: x, onClicked: widget.onImageSelected, backToGallary: () => { widget.onImageSelected(gallery ??= getGallery()) },);
  }

  void onLogout() {
    setState(() {
      apiKeyTextController.text = '';
      searchTextController.text = '';
      client = null;
      postWidgets.clear();
    });
  }

  void onLogin() async {
    if (usernameTextController.text.isNotEmpty && apiKeyTextController.text.isNotEmpty) {
      E621Client testClient = E621Client(
          host: Uri.parse('https://e621.net'), 
          login: usernameTextController.text, 
          apiKey: apiKeyTextController.text, 
          userAgent: 'Fange/1.0 (by deadi9 on e621)'
        );
        
        try {
          await testClient.posts.list(limit: 1);
        } on ClientException catch (e) {
          setState(() {
            loginMessage = e.message;
          });
          return;
        } on E621Exception catch (e) {
          setState(() {
            switch (e.statusCode) {
              case 401:
                loginMessage = 'Your authorization is invalid. Ensure your username and api key are correct.';
              default:
                loginMessage = '${e.message} Error Code: ${e.statusCode}';
            }
          });
          
          return;
        }

      setState(() {
          loginMessage = '';
          client = testClient;
      });

      await Preferences.setE621APIKey(testClient.apiKey);
      await Preferences.setE621Username(testClient.login);
    }
  }
}