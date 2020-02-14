import 'package:flutter/material.dart';
import 'package:join_me/party_creation.dart';
import 'package:join_me/party_creation_map.dart';

const String homeRoute = '/';
const String partyCreation = '/partyCreation';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute<PartyCreationMap>(builder: (_) => PartyCreationMap());
      case partyCreation:
        return MaterialPageRoute<PartyCreation>(builder: (_) => PartyCreation());
      default:
        return MaterialPageRoute<Container>(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}