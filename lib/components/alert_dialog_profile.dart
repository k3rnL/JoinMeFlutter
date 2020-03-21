import 'package:flutter/material.dart';
import 'package:join_me/components/text_input.dart';

class AlertDialogProfile extends StatefulWidget {
  const AlertDialogProfile({this.title, this.hintText, this.onValueChanged});

  final String title;
  final String hintText;
  final Function(String) onValueChanged;

  @override
  _AlertDialogProfileState createState() => _AlertDialogProfileState();
}

class _AlertDialogProfileState extends State<AlertDialogProfile> {
  String fieldValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              child: TextInput(
            hintText: widget.hintText,
            onTextChanged: (String value) {
              setState(() {
                fieldValue = value;
              });
            },
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
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        FlatButton(
          onPressed: () {
            widget.onValueChanged(fieldValue);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Apply',
          ),
        ),
      ],
    );
  }
}
