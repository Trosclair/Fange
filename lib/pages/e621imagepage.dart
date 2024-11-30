import 'dart:typed_data';
import 'package:e621/e621.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:flutter/material.dart';

class E621ImagePage extends StatelessWidget {
  final Post post;
  final Uint8List mediaBytes;

  const E621ImagePage({super.key, required this.post, required this.mediaBytes});

  @override
  Widget build(BuildContext context) {
    ImageProvider img = Image.memory(mediaBytes).image;

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
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width - 20),
            child: Column(
              children: [
                Image(image: img),
                Text(post.description, style: const TextStyle(color: Colors.white,))
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget onImageError(BuildContext context, Object error, StackTrace? stackTrace) {
    return const Text('IMAGE NOT FOUND', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, backgroundColor: Colors.black));
  }
}