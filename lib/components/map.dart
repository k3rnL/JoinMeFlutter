import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:join_me/themes/map_theme.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  Map({this.onRegionChanged});

  final void Function(LatLng) onRegionChanged;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> _getDeviceLocation() async {
    final Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude), 6));
  }

  @override
  Widget build(BuildContext context) {
    String theme = Provider.of<MapTheme>(context).theme;

    Provider.of<MapTheme>(context).addListener(() async {
      (await _controller.future).setMapStyle(Provider.of<MapTheme>(context, listen: false).theme);
      setState(() {theme = Provider.of<MapTheme>(context, listen: false).theme;});
      print('cococuocucocuou' + Provider.of<MapTheme>(context, listen: false).isLight().toString());
    });

    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: Map._kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _getDeviceLocation();
            controller.setMapStyle(theme);
          },
          onCameraMove: (CameraPosition camera) {
            widget.onRegionChanged(camera.target);
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        ),
        Center(
          child: Pin(),
        ),
      ],
    );
  }
}

class Pin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          child: const Image(image: AssetImage('assets/images/pin.png')),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
