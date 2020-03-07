import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {
  Map({this.onRegionChanged});

  final void Function(LatLng) onRegionChanged;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> _getDeviceLocation() async {
    final Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 6));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _getDeviceLocation();
          },
          onCameraMove: (CameraPosition camera) {
            onRegionChanged(camera.target);
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
