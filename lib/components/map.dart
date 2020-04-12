import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:join_me/themes/map_theme.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({this.onRegionChanged});

  final void Function(LatLng) onRegionChanged;

  static const CameraPosition _kFrance = CameraPosition(
    target: LatLng(46.227638, 2.213749),
    zoom: 5,
  );

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Function() _updateOnThemeChange;

  Future<void> _getDeviceLocation() async {
    final Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude), 10));
  }

  @override
  void initState() {
    super.initState();
    _updateOnThemeChange = () async {
      if (context == null)
        return;
      (await _controller.future)
          .setMapStyle(Provider.of<MapTheme>(context, listen: false).theme);
      setState(() {});
    };
    Provider.of<MapTheme>(context, listen: false).addListener(_updateOnThemeChange);
  }

  @override
  Widget build(BuildContext context) {
    final String theme = Provider.of<MapTheme>(context).theme;

    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: MapWidget._kFrance,
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
