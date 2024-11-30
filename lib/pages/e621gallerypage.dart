import 'package:e621/e621.dart';
import 'package:fange/pages/e621LoginPage.dart';
import 'package:fange/pages/homepage.dart';
import 'package:fange/preferences/preferences.dart';
import 'package:fange/widgets/appbars/e621appbar.dart';
import 'package:fange/widgets/buttons/postpreviewbutton.dart';
import 'package:fange/widgets/drawers/e621drawer.dart';
import 'package:http/http.dart';
import 'package:fange/themes/e621theme.dart';
import 'package:flutter/material.dart';

class E621GalleryPage extends StatefulWidget {
  final E621Client client;

  const E621GalleryPage({super.key, required this.client});

  @override
  State<E621GalleryPage> createState() => _E621GalleryPageState();
}

class _E621GalleryPageState extends State<E621GalleryPage> {
  int pageNumber = 1;

  final TextEditingController searchTextController = TextEditingController();

  String scrollingError = '';
  ScrollController? scrollController;
  bool isLoadingPreviews = false;
  bool hasRanOutOfPosts = false;

  List<Widget> postWidgets = <Widget>[]; 
  
  @override
  Widget build(BuildContext context) { 
    scrollController = ScrollController();
    scrollController!.addListener(onScroll);
    return Scaffold(
      backgroundColor: E621Theme.appBarColor,
      appBar: E621AppBar(textController: searchTextController, onSearchPressed: onSearchPressed),
      endDrawer: E621Drawer(onLogoutPressed: onLogout),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: postWidgets,
        ),
      ),
    );
  }

  void onScroll() async {
    if (scrollController != null) {
      if (scrollController!.offset >= (scrollController!.position.maxScrollExtent - MediaQuery.sizeOf(context).height) && !scrollController!.position.outOfRange) {
        if (!isLoadingPreviews) {

          isLoadingPreviews = true;
          if (!hasRanOutOfPosts) {
            pageNumber++;

            List<Widget> tempPostWidgets = await getPostPreviews();

            hasRanOutOfPosts = tempPostWidgets.isEmpty;

            setState(() {
              postWidgets.addAll(tempPostWidgets);
            });
          }
          isLoadingPreviews = false;
        }
      }
    }
  }

  void onSearchPressed() async {
    postWidgets.clear();
    
    List<Widget> tempPostWidgets = await getPostPreviews();

    setState(() {
      postWidgets.addAll(tempPostWidgets);
    });
  }

  Future<List<Widget>> getPostPreviews() async {
    List<Widget> tempPostWidgets = [];

    if (searchTextController.text.isNotEmpty) {
      List<String> tags = searchTextController.text.split(' ');
      List<Post>? posts;

      try {
        posts = await widget.client.posts.list(limit: 320, tags: tags, page: pageNumber);
      } on ClientException catch (e) {
        scrollingError = e.message;
        return [];
      } on E621Exception catch (e) {
        setState(() {
          switch (e.statusCode) {
            case 401:
              Navigator.push(context, MaterialPageRoute(builder: (context) => E621LoginPage(apiKey: widget.client.apiKey, username: widget.client.login)));
              return;
            default:
              scrollingError = '${e.message} Error Code: ${e.statusCode}';
          }
        });
        return [];
      }

      for (Post x in posts.where((y) => y.preview.url != null)) {
        tempPostWidgets.add(PostPreviewButton(post: x, client: widget.client,));
      }
    }

    return tempPostWidgets;
  }

  void onLogout() async {
    await Preferences.setE621APIKey('');
    await Preferences.setE621Username('');

    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}