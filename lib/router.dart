import 'package:flutter/material.dart';
import 'package:join_me/pages/login_page.dart';
import 'package:join_me/pages/party_detail.dart';
import 'package:join_me/pages/splash_page.dart';
import 'package:join_me/pages/party_creation_page.dart';
import 'package:join_me/pages/list_party_page.dart';
import 'package:join_me/pages/profil_page.dart';
import 'package:join_me/pages/home_page.dart';

const String landingRoute = '/';
const String loginRoute = '/login';
const String homeRoute = '/home';
const String profileRoute = '/profile';
const String partyCreationMapRoute = '/partyCreation/map';
const String listPartyRoute = '/listParty';
const String partyDetail = '/party/detail';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingRoute:
        return MaterialPageRoute<SplashPage>(builder: (_) => const SplashPage());
      case loginRoute:
        return MaterialPageRoute<LoginPage>(builder: (_) => LoginPage());
      case homeRoute:
        return MaterialPageRoute<HomePage>(builder: (_) => const HomePage());
      case profileRoute:
        return MaterialPageRoute<ProfilePage>(builder: (_) => ProfilePage());
      case partyCreationMapRoute:
        return MaterialPageRoute<PartyCreationPage>(builder: (_) => PartyCreationPage());
      case listPartyRoute:
        return MaterialPageRoute<ListPartyPage>(builder: (_) => const ListPartyPage());
      case partyDetail:
        return MaterialPageRoute<PartyDetailPage>(builder: (_) => PartyDetailPage());
      default:
        return MaterialPageRoute<Container>(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
