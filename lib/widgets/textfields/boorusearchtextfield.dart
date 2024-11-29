import 'package:flutter/material.dart';

class BooruSearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final VoidCallback onSearchPressed;

  const BooruSearchTextField({super.key, required this.hintText, required this.textController, required this.onSearchPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: textController,
        onSubmitted: (value) => {
          onSearchPressed()
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: IconButton(onPressed: onSearchPressed, icon: const Icon(Icons.search)),
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 172, 168, 168),
            fontSize: 14
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none
          ),
          suffixIcon: SizedBox(
            width: 60,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    color: Colors.black,
                    indent: 5,
                    endIndent: 5,
                    thickness: 0.3,
                  ),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: SizedBox(height: 30, width: 30, child: IconButton(
                        onPressed:() => {},
                        icon: const Icon(Icons.filter_alt)
                    )),
                  ),

                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}