import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor("assets/animations/loading_circle.flr2d"),
    );
  }
}
