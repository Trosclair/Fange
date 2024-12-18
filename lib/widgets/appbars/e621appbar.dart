import 'package:fange/pages/homepage.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:fange/widgets/textfields/boorusearchtextfield.dart';
import 'package:flutter/material.dart';

class E621AppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSearchPressed;
  final TextEditingController textController;

  const E621AppBar({super.key, required this.textController, required this.onSearchPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: E621Theme.appBarColor,
      elevation: 1.0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
        icon: const Icon(Icons.home),
        color: Colors.white,
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BooruSearchTextField(hintText: 'Shinx', textController: textController, onSearchPressed: onSearchPressed)
        ],
      ),
      actions: [
        IconButton(
          onPressed: () { Scaffold.of(context).openEndDrawer(); }, 
          icon: const Icon(Icons.settings), 
          color: Colors.white,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}