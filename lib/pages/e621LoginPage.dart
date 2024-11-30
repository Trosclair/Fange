import 'package:e621/e621.dart';
import 'package:fange/pages/e621page.dart';
import 'package:fange/pages/homepage.dart';
import 'package:fange/preferences/preferences.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:fange/widgets/textfields/passwordtextfield.dart';
import 'package:fange/widgets/textfields/usernametextfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class E621LoginPage extends StatefulWidget {
  final String? apiKey;
  final String? username;

  const E621LoginPage({super.key, required this.apiKey, required this.username});

  @override
  State<E621LoginPage> createState() => _E621LoginPageState();

  static Future<(E621Client?, String)> tryLogin(String username, String apiKey) async {
    E621Client testClient = E621Client(
        host: Uri.parse('https://e621.net'), 
        login: username, 
        apiKey: apiKey, 
        userAgent: 'Fange/1.0 (by deadi9 on e621)'
      );
      
      try {
        await testClient.posts.list(limit: 1);
      } on ClientException catch (e) {
        return (null, e.message);
      } on E621Exception catch (e) {
        String loginMessage = '';
        switch (e.statusCode) {
          case 401:
            loginMessage = 'Your authorization is invalid. Ensure your username and api key are correct.';
          default:
            loginMessage = '${e.message} Error Code: ${e.statusCode}';
        }
        
        return (null, loginMessage);
      }

      return (testClient, '');
  }
}

class _E621LoginPageState extends State<E621LoginPage> {
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController apiKeyTextController = TextEditingController();

  E621Client? client;
  String loginMessage = '';
  
  @override
  Widget build(BuildContext context) {
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
                  TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())), style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.yellow)), child: const Text('Cancel')),
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

  void onLogin() async {
    if (usernameTextController.text.isNotEmpty && apiKeyTextController.text.isNotEmpty) {
      (E621Client?, String) clientTuple = await E621LoginPage.tryLogin(usernameTextController.text, apiKeyTextController.text);
      E621Client? testClient = clientTuple.$1;

      if (testClient != null) {
        await Preferences.setE621APIKey(testClient.apiKey);
        await Preferences.setE621Username(testClient.login);

        Navigator.push(context, MaterialPageRoute(builder: (context) => E621Page(client: testClient)));
      }
      else {
        setState(() {
          loginMessage = clientTuple.$2;
        });
      }
    }
  }
}