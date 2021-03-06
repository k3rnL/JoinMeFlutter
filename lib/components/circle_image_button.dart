import 'package:flutter/material.dart';

class CircleImageButton extends StatelessWidget {
  const CircleImageButton({this.image, this.onTap});

  final Widget image;
  final VoidCallback onTap;

//  final Color color = Theme.of(context).buttonColor;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: const StadiumBorder(),
        onPressed: onTap,
        child: image
    );
  }
}
