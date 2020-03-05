import 'package:flutter/material.dart';

class StaticMap extends StatelessWidget {
  const StaticMap({
    @required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Image.network(
        generateImage(),
        fit: BoxFit.cover,
      ),
    );
  }
}

String generateImage() {
  return 'https://maps.googleapis.com/maps/api/staticmap?center=${Uri.encodeFull('43.604350,1.505164')}&zoom=13&size=1800x1800&maptype=roadmap&markers=color:blue%7C${Uri.encodeFull('43.604350,1.505164')}&key=AIzaSyAfv8IPCxhiURtrI8tDyQptGEVQoOl0G3c';
}
