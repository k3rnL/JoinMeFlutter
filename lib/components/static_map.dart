import 'package:flutter/material.dart';

class StaticMap extends StatelessWidget {
  const StaticMap({
    @required this.size,
    @required this.address
  });

  final Size size;
  final String address;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Image.network(
        generateImage(address),
        fit: BoxFit.cover,
      ),
    );
  }
}

String generateImage(String address) {
  final String encoded = Uri.encodeFull(address);
  return 'https://maps.googleapis.com/maps/api/staticmap?center=$encoded&zoom=13&size=1800x1800&maptype=roadmap&markers=color:blue%7C$encoded&key=AIzaSyAfv8IPCxhiURtrI8tDyQptGEVQoOl0G3c';
}
