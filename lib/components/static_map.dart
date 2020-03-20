import 'package:flutter/material.dart';
import 'package:join_me/themes/map_theme.dart';
import 'package:provider/provider.dart';

class StaticMap extends StatelessWidget {
  const StaticMap({@required this.size, @required this.address});

  final Size size;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      SizedBox(
        width: size.width,
        height: size.height,
        child: Image.network(
          Provider.of<MapTheme>(context).getStaticMapUrl(address),
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
            colors: <Color>[Colors.black.withOpacity(0.0), Theme.of(context).backgroundColor.withOpacity(1.0)],
            tileMode: TileMode.clamp, // repeats the gradient over the canvas
          ),
        ),
      )
    ]);
  }
}

String generateImage(String address) {
  final String encoded = Uri.encodeFull(address);
  return 'https://maps.googleapis.com/maps/api/staticmap?center=$encoded&zoom=13&size=1800x1800&maptype=roadmap&markers=color:blue%7C$encoded&key=AIzaSyAfv8IPCxhiURtrI8tDyQptGEVQoOl0G3c';
}
