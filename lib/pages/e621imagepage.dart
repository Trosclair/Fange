import 'package:e621/e621.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
                Text(widget.post.description, style: const TextStyle(color: Colors.white,)),
                buildCommentsSection()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget buildCommentsSection() {
    if (widget.comments.isNotEmpty) {
      return Column(
        children: buildComments(),
      );
    }
    else {
      return Container();
    }
  }

  List<Widget> buildComments(){
    List<Widget> comments = [];
    widget.comments.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    for (Comment comment in widget.comments) {
      comments.add(
        Container(
          color: E621Theme.secondaryColor,
          child: Row(
            children: [
              SizedBox(
                width: 130,
                child: Container(
                  color: E621Theme.tertiaryColor,
                  child: Column(
                    children: [
                      Text(comment.creatorName, style: const TextStyle(color: Colors.white)),
                      const Text('Member', style: TextStyle(color: Colors.white)),
                      const SizedBox(
                        width: 50,
                        height: 50,
                        child: Placeholder(),
                      ),
                      Text(DateFormat("MM-dd-yyyy").format(DateTime.parse(comment.createdAt)), style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.body, 
                      style: const TextStyle(color: Colors.white),
                      softWrap: true,
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () => { }, icon: const Icon(Icons.arrow_upward, color: Colors.grey)),
                        Text(comment.score.toString(), style: const TextStyle(color: Colors.green)),
                        IconButton(onPressed: () => { }, icon: const Icon(Icons.arrow_downward, color: Colors.grey)),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(onPressed: () => { }, child: const Text('Reply', style: TextStyle(color: Colors.grey))),
                        const Text('|', style: TextStyle(color: Colors.white)),
                        TextButton(onPressed: () => { }, child: const Text('Report', style: TextStyle(color: Colors.grey)))
                      ],
                    )
                  ]
                ),
              )
            ],
          ),
        )
      );
      comments.add(const SizedBox(height: 10));
    }

    return comments;
  }
}