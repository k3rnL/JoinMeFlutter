import 'package:flutter/material.dart';
import 'package:join_me/components/InsideAlertDialogProfil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ListItem extends StatelessWidget {
  const ListItem({this.title, this.subtitle, this.onTap, this.image});

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final ImageProvider<dynamic> image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 70,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Row(
          children: <Widget>[
            if (image != null) ... <Widget>[
              const SizedBox(width: 15,),
              CircleAvatar(backgroundImage: image)
            ],
            const SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
