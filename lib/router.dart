import 'package:flutter/material.dart';
import 'package:join_me/auth.dart';
import 'package:join_me/pages/login_page.dart';
import 'package:join_me/pages/splash_page.dart';
import 'package:join_me/pages/party_creation_page.dart';
import 'package:join_me/home_page.dart';

const String landingRoute = '/';
const String authRoute = '/auth';
const String loginRoute = '/login';
const String homeRoute = '/home';
const String partyCreationMapRoute = '/partyCreation/map';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingRoute:
        return MaterialPageRoute<SplashPage>(builder: (_) => const SplashPage());
      case authRoute:
        return MaterialPageRoute<Auth>(builder: (_) => Auth());
      case loginRoute:
        return MaterialPageRoute<LoginPage>(builder: (_) => LoginPage());
      case homeRoute:
        return MaterialPageRoute<HomePage>(builder: (_) => const HomePage());
      case partyCreationMapRoute:
        return MaterialPageRoute<HomePage>(builder: (_) => PartyCreationPage());
      default:
        return MaterialPageRoute<Container>(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
