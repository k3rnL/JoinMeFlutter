import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CircleImageButton extends StatelessWidget {
  CircleImageButton({this.image, this.onTap});

  final Widget image;
  final VoidCallback onTap;

//  final Color color = Theme.of(context).buttonColor;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: StadiumBorder(),
        onPressed: onTap,
        child: image
    );
  }
}
