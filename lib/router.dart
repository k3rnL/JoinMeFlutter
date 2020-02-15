import 'package:flutter/material.dart';
import 'package:join_me/auth.dart';
import 'package:join_me/landing_page.dart';
import 'package:join_me/party_creation.dart';
import 'package:join_me/party_creation_map.dart';
import 'package:provider/provider.dart';

const String landingRoute = '/';
const String authRoute = '/auth';
const String homeRoute = '/home';
const String partyCreationMapRoute = '/partyCreation/map';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingRoute:
        return MaterialPageRoute<LandingPage>(builder: (_) => LandingPage());
      case authRoute:
        return MaterialPageRoute<Auth>(builder: (_) => Auth());
      case homeRoute:
        return MaterialPageRoute<PartyCreationMap>(
            builder: (_) => PartyCreationMap());
      case partyCreationMapRoute:
        return MaterialPageRoute<PartyCreation>(
            builder: (_) => ChangeNotifierProvider<Counter>(
                  child: PartyCreation(),
                  create: (_) => Counter(0),
                ));
      default:
        return MaterialPageRoute<Container>(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
