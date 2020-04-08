import 'package:flutter/material.dart';
import 'package:join_me/themes/map_theme.dart';
import 'package:provider/provider.dart';

class StaticMap extends StatelessWidget {
  const StaticMap({@required this.size, @required this.address});

  final Size size;
  final String address;

  @override
  Widget build(BuildContext context) {
    final Color gradientColor = Provider.of<MapTheme>(context).isLight()
        ? Colors.white.withOpacity(0.0)
        : Colors.black.withOpacity(0.0);

    return Stack(children: <Widget>[
      SizedBox(
        width: size.width,
        height: size.height,
        child: Image.network(
          Provider.of<MapTheme>(context)
              .getStaticMapUrl(Uri.encodeFull(address)),
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const <double>[0.45, 1.0],
            colors: <Color>[
              gradientColor,
              Theme.of(context).backgroundColor.withOpacity(1.0)
            ],
            tileMode: TileMode.clamp, // repeats the gradient over the canvas
          ),
        ),
      )
    ]);
  }
}
