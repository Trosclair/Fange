import 'package:e621/e621.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:flutter/material.dart';

class PostPreviewButton extends StatelessWidget {
  final Post post;
  final Function(Widget post) onClicked;
  final VoidCallback backToGallary;

  const PostPreviewButton({super.key, required this.post, required this.onClicked, required this.backToGallary});

  @override
  Widget build(BuildContext context) {
    String? url = post.preview.url?.toString() ?? post.sample.url?.toString();
    if (url != null) {
      return SizedBox(
        width: 120,
        height: 120,
        child: IconButton(
          onPressed: () => createImagePage(context),
          icon: FadeInImage.assetNetwork(placeholder: 'assets/gifs/loading.gif', image: url),
        ),
      );
    }

    return const Placeholder();  
  }

  void createImagePage(BuildContext context) {
    String? url = post.file.url?.toString();
    if (url != null) {
      Widget page = Scaffold(
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
                  FadeInImage.assetNetwork(placeholder: 'assets/gifs/loading.gif', image: url),
                  Text(post.description, style: const TextStyle(color: Colors.white,))
                ],
              ),
            ),
          ),
        )
      );
      onClicked(page);
    }
  }
}