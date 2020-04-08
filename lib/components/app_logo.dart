import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends AnimatedWidget {
  const AppLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  static final Tween<double> _opacityTween = Tween<double>(begin: 1, end: 0);
  static final Tween<double> _positionTween = Tween<double>(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final double yPos = MediaQuery.of(context).size.height *
        0.30 *
        _positionTween.evaluate(animation);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(_opacityTween.evaluate(animation)),
      child: Container(
        transform: Matrix4.translationValues(0, -yPos, 0),
        margin: const EdgeInsets.all(40),
        child: SvgPicture.asset('assets/images/logo.svg'),
      ),
    );
  }
}
