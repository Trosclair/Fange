import 'package:flutter/material.dart';

class BooruSiteTile extends StatelessWidget {
  final Function() changeToPage;
  final Color tileBackground;
  final String urlOfIcon;

  const BooruSiteTile({super.key, required this.changeToPage, required this.tileBackground, required this.urlOfIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: InkWell( 
        onTap: changeToPage, 
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: tileBackground,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              image: AssetImage(urlOfIcon)
            )
          ),
        )
      ),
    );
  }
}