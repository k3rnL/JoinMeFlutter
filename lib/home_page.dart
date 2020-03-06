import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/text_input.dart';
import 'package:join_me/router.dart';
import 'package:join_me/themes/light.dart';
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
      theme: buildLightTheme(),
      home: Scaffold(
        body: Map(onRegionChanged: (LatLng latlng) {
          print(latlng);
        }),
        floatingActionButton: TextInput(onTextChanged: (String v) {}, hintText: 'Oui',),
      ),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
