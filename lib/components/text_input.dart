import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({this.hintText = '', this.onTextChanged});

  final Function(String) onTextChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 280,
        height: 45,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 0.1, // has the effect of extending the shadow
              offset: Offset(
                3.0, // horizontal, move right 10
                3.0, // vertical, move down 10
              ),
            )
          ],
//          borderRadius: new BorderRadius.all(),
//          gradient: new LinearGradient(...),
        ),
        child: TextField(
          style: TextStyle(fontSize: 16),
          onChanged: onTextChanged,
          decoration: InputDecoration(hintText: hintText),
        ));
  }
}
