import 'package:e621/e621.dart';
import 'package:fange/pages/e621imagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostPreviewButton extends StatelessWidget {
  final Post post;
  final Function(Widget post) onClicked;
  final VoidCallback backToGallary;

  const PostPreviewButton({super.key, required this.post, required this.onClicked, required this.backToGallary});

  Widget onImageError(BuildContext context, Object error, StackTrace? stackTrace) {
    return const Text('IMAGE NOT FOUND', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, backgroundColor: Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    String? url = post.preview.url?.toString() ?? post.sample.url?.toString();
    if (url != null) {
      List<Widget> stackWidgets = [
        Center(
          child: IconButton(
            onPressed: () => createImagePage(context),
            icon: FadeInImage.assetNetwork(placeholder: 'assets/gifs/loading.gif', image: url, imageErrorBuilder: onImageError),
          ),
        ),
      ];

      Widget? mediaHasSpecialFileExtenison = createFileExtensionWidget(post.file.url);
      if (mediaHasSpecialFileExtenison != null) {
        stackWidgets.add(mediaHasSpecialFileExtenison);
      }

      return SizedBox(
        height: 145,
        width: 120,
        child: Column(
          children: [ 
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                children: stackWidgets
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_upward_rounded, color: Colors.green, size: 10),
                Text(post.score.total.toString(), style: const TextStyle(color: Colors.green, fontSize: 10)),
                const SizedBox(width: 3),
                const Icon(CupertinoIcons.heart_fill, color: Colors.red, size: 10),
                Text(post.favCount.toString(), style: const TextStyle(color: Colors.red, fontSize: 10)),
                const SizedBox(width: 3),
                const Icon(CupertinoIcons.bubble_left, color: Colors.white, size: 10),
                Text(post.commentCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 10)),
                const SizedBox(width: 5),
                Text(post.rating.toString().toUpperCase(), style: const TextStyle(color: Colors.green, fontSize: 10)),
              ],
            )
          ]
        ),
      );
    }

    return const Placeholder();  
  }

  // Add a small widget to denote if the actual image is a gif or webm.
  Widget? createFileExtensionWidget(Uri? uri) {
    Widget? gifOrWebm;
    String? url = uri?.toString();

    if (url != null) {
      if (url.toLowerCase().endsWith('.webm')) {
        gifOrWebm = const Align(
          alignment: Alignment.topRight, 
          child: Text(
            'WEBM', 
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.black,
              fontSize: 12
            ),
          )
        );
      }
      else if (url.toLowerCase().endsWith('.gif')) {
        gifOrWebm = const Align(
          alignment: Alignment.topRight, 
          child: Text(
            'GIF', 
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.black,
              fontSize: 12
            ),
          )
        );
      }
    }

    return gifOrWebm;
  }

  void createImagePage(BuildContext context) {
    onClicked(E621ImagePage(post: post, backToGallary: backToGallary));
  }
}