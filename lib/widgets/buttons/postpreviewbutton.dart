import 'package:e621/e621.dart';
import 'package:fange/pages/e621imagepage.dart';
import 'package:flutter/cupertino.dart';
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
        height: 145,
        width: 120,
        child: Column(
          children: [ 
            SizedBox(
              width: 120,
              height: 120,
              child: IconButton(
                onPressed: () => createImagePage(context),
                icon: FadeInImage.assetNetwork(placeholder: 'assets/gifs/loading.gif', image: url),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_upward_rounded, color: Colors.green, size: 14),
                Text(post.score.total.toString(), style: const TextStyle(color: Colors.green, fontSize: 14)),
                const SizedBox(width: 3),
                const Icon(CupertinoIcons.heart_fill, color: Colors.red, size: 14),
                Text(post.favCount.toString(), style: const TextStyle(color: Colors.red, fontSize: 14)),
                const SizedBox(width: 3),
                const Icon(CupertinoIcons.bubble_left, color: Colors.white, size: 14),
                Text(post.commentCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(width: 5),
                Text(post.rating.toString().toUpperCase(), style: const TextStyle(color: Colors.green, fontSize: 14)),
              ],
            )
          ]
        ),
      );
    }

    return const Placeholder();  
  }

  void createImagePage(BuildContext context) {
    onClicked(E621ImagePage(post: post, backToGallary: backToGallary));
  }
}