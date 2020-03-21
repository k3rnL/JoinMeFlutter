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
  String name = 'assets/images/user.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Map(onRegionChanged: (LatLng latlng) {
            Provider.of<Party>(context, listen: false).address = latlng.latitude.toString() + ',' + latlng.longitude.toString();
          }),
          Positioned(
            top: MediaQuery.of(context).padding.top + 15,
            left: 15,
            width: 65,
            height: 65,
            child: CircleImageButton(
                image: Image.asset(name, color: Theme.of(context).buttonColor,),
                onTap: () {
                  Navigator.of(context).pushNamed(profileRoute);
                }),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 15,
            right: 15,
            width: 65,
            height: 65,
            child: CircleImageButton(
                image: Image(image: const AssetImage('assets/images/list.png'), color: Theme.of(context).buttonColor),
                onTap: () {
                  Navigator.of(context).pushNamed(listPartyRoute);
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
