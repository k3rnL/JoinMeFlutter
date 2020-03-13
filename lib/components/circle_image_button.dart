import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CircleImageButton extends StatelessWidget {
  const CircleImageButton({this.image, this.onTap});

  final Image image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      activeOpacity: 0,
      onTap: onTap,
      child: image,
    );
  }
}
