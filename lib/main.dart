import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:join_me/router.dart';
import 'package:join_me/services/api_service.dart';
import 'package:join_me/themes/dark.dart';
import 'package:join_me/themes/light.dart';
import 'package:join_me/themes/map_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/party.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final MapTheme theme = MapTheme();
  final FirebaseMessaging fcm = FirebaseMessaging();
  final Party party = Party();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<FirebaseAuth>(
            create: (BuildContext c) => FirebaseAuth.instance),
        Provider<FirebaseMessaging>(
            create: (BuildContext c) => widget.fcm),
        ListenableProvider<User>(create: (BuildContext c) => User()),
        ListenableProvider<Party>(create: (BuildContext c) => widget.party),
        ChangeNotifierProvider<MapTheme>(create: (BuildContext c) => widget.theme)
      ],
      child: FutureBuilder<void>(
        future: loadThemeSettings(widget.theme),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            initNotifications(context, widget.fcm);
            return Consumer<MapTheme>(
              builder: (BuildContext context, MapTheme theme, Widget w) {
                return MaterialApp(
                  title: 'JoinMe',
                  navigatorKey: _navigator,
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: Router.generateRoute,
                  initialRoute: landingRoute,
                  theme: theme.theme == theme.themeLight
                      ? buildLightTheme()
                      : buildDarkTheme(),
                  themeMode: ThemeMode.dark,
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<void> initNotifications(BuildContext context, FirebaseMessaging fcm) async {
    await fcm.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        final Party party = await ApiService.getParty(message['data']['party_id']);
        widget.party.setData(party);
        _navigator.currentState.pushNamed('/party/detail');
      },
      onBackgroundMessage: null,
      onLaunch: (Map<String, dynamic> message) async {
        final Party party = await ApiService.getParty(message['data']['party_id']);
        widget.party.setData(party);
        _navigator.currentState.pushNamed('/party/detail');
      },
      onResume: (Map<String, dynamic> message) async {
        final Party party = await ApiService.getParty(message['data']['party_id']);
        widget.party.setData(party);
        _navigator.currentState.pushNamed('/party/detail');
      },
    );
  }

}

Future<void> loadThemeSettings(MapTheme theme) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String dark =
      await rootBundle.loadString('assets/themes/map_dark.json');
  theme.themeDark = dark;

  final bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
  if (isDarkTheme)
    theme.setTheme(false);
  else
    theme.setTheme(true);
}
