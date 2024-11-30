import 'dart:io';
import 'package:e621/e621.dart';
import 'package:fange/pages/e621imagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPreviewButton extends StatelessWidget {
  final Post post;
  final E621Client client;

  const PostPreviewButton({super.key, required this.post, required this.client});

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
            onPressed: () => onPreviewClicked(context),
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

  void onPreviewClicked(BuildContext context) async {
    Widget img = const Placeholder();
    Uri? url = post.file.url;
    try {
      if (url != null) {
        Future.delayed(const Duration(seconds: 1));

        http.Response resp = await http.get(url);
        img = Image(image: Image.memory(resp.bodyBytes).image);

        
      }
    }
    on Exception catch (_) {
      img = const Text('Image failed to Load...', style: TextStyle(color: Colors.red));
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => E621ImagePage(post: post, img: img,)));
  }
}