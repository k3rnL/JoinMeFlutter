import 'package:flutter/material.dart';
import 'package:join_me/components/text_input.dart';

class InsideAlertDialogProfil extends StatelessWidget {
  const InsideAlertDialogProfil({this.label, this.hintTextProfil,});

final String label;
final String hintTextProfil;

@override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0)),
      title: Text(label),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              child: TextInput(
                hintText: hintTextProfil,
              )),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            //Put your code here which you want to execute on Cancel button click.
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
        ),
        const FlatButton(
          onPressed: null,
          child: Text(
            "Apply",
          ),
        ),
      ],
    );
  }
}