import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:join_me/services/api_service.dart';
import 'package:join_me/router.dart';
import 'components/map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: Scaffold(
        body: Map(onRegionChanged: (LatLng latlng) {
          print(latlng);
        }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(partyCreationMapRoute, arguments: context);
          },
          label: const Text('To the lake!'),
          icon: Icon(Icons.directions_boat),
        ),
      ),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
