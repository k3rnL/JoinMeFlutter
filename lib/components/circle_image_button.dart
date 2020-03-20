import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CircleImageButton extends StatelessWidget {
  CircleImageButton({this.image, this.onTap});

  final Widget image;
  final VoidCallback onTap;

//  final Color color = Theme.of(context).buttonColor;

  @override
  Widget build(BuildContext context) {
    print('is built');
    return TouchableOpacity(
      activeOpacity: 0,
      onTap: onTap,
      child: Image.asset('assets/images/user.png', color: Theme.of(context).buttonColor,),
    );
  }
}
