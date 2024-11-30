import 'package:e621/e621.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:flutter/material.dart';

class E621ImagePage extends StatelessWidget {
  final Post post;
  final VoidCallback backToGallary;

  const E621ImagePage({super.key, required this.post, required this.backToGallary});

  @override
  Widget build(BuildContext context) {
    String? url = post.file.url?.toString();
    Widget page = const Placeholder();

    if (url != null) {
      page = Scaffold(
        backgroundColor: E621Theme.appBarColor,
        appBar: AppBar(
          backgroundColor: E621Theme.appBarColor, 
          leading: IconButton(
            onPressed: backToGallary, 
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
                  FadeInImage.assetNetwork(placeholder: 'assets/gifs/loading.gif', image: url, imageErrorBuilder: onImageError,),
                  Text(post.description, style: const TextStyle(color: Colors.white,))
                ],
              ),
            ),
          ),
        )
      );
    }
    return page;
  }

  Widget onImageError(BuildContext context, Object error, StackTrace? stackTrace) {
    return const Text('IMAGE NOT FOUND', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, backgroundColor: Colors.black));
  }
}