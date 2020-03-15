import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/circle_image_button.dart';
import 'package:join_me/router.dart';
import 'package:provider/provider.dart';
import '../components/map.dart';
import '../models/party.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Map(onRegionChanged: (LatLng latlng) {
            Provider.of<Party>(context, listen: false).address = latlng.latitude.toString() + ',' + latlng.longitude.toString();
//            setState(() {
//              position = latlng;
//            });
          }),
          Positioned(
            top: MediaQuery.of(context).padding.top + 25,
            left: 25,
            width: 45,
            height: 45,
            child: CircleImageButton(
                image: const Image(image: AssetImage('assets/images/user.png')),
                onTap: () {
                  Navigator.of(context).pushNamed(profileRoute);
                }),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 25,
            right: 25,
            width: 45,
            height: 45,
            child: CircleImageButton(
                image: const Image(image: AssetImage('assets/images/list.png')),
                onTap: () {
                  Navigator.of(context).pushNamed(profileRoute);
                }),
          )
        ],
      ),
      floatingActionButton: Button(
        label: 'Create a party !  🎉',
        onPressed: () {
          Navigator.of(context).pushNamed(partyCreationMapRoute);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
