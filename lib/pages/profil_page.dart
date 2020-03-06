import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:join_me/components/static_map.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class ProfilPage extends StatelessWidget {
  ProfilPage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 225,
                  child: Image.network(
                    'https://c1.lestechnophiles.com/www.numerama.com/content/uploads/2019/05/trou-noir-espace-univers-astronomie.jpg?resize=1212,712',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    child: Container(
                      width: 50,
                      height: 50,
                      child:
                      const Image(image: AssetImage('assets/images/pin.png')),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
