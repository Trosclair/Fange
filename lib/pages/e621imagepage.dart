import 'package:e621/e621.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:flutter/material.dart';


class E621ImagePage extends StatefulWidget {
  final Post post;
  final Widget img;
  final List<Comment> comments;

  const E621ImagePage({super.key, required this.post, required this.img, required this.comments});

  @override
  State<E621ImagePage> createState() => _E621ImagePageState();
}

class _E621ImagePageState extends State<E621ImagePage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: E621Theme.appBarColor,
      appBar: AppBar(
        backgroundColor: E621Theme.appBarColor, 
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(
            Icons.arrow_back, 
            color: Colors.white
          )
        )
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width - 20),
            child: Column(
              children: [
                widget.img,
                Text(widget.post.description, style: const TextStyle(color: Colors.white,))
              ],
            ),
          ),
        ),
      )
    );
  }
}