import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:join_me/router.dart';
import 'package:join_me/themes/dark.dart';
import 'package:join_me/themes/light.dart';
import 'package:join_me/themes/map_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/party.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MapTheme theme = MapTheme();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<FirebaseAuth>(
            create: (BuildContext c) => FirebaseAuth.instance),
        Provider<FirebaseMessaging>(
            create: (BuildContext c) => FirebaseMessaging()),
        ListenableProvider<User>(create: (BuildContext c) => User()),
        ListenableProvider<Party>(create: (BuildContext c) => Party()),
        ChangeNotifierProvider<MapTheme>(create: (BuildContext c) => theme)
      ],
      child: FutureBuilder<void>(
        future: loadThemeSettings(theme),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Consumer<MapTheme>(
            builder: (BuildContext context, MapTheme theme, Widget w) {
              return MaterialApp(
                title: 'JoinMe',
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
        },
      ),
    );
  }
}

Future<void> loadThemeSettings(MapTheme theme) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String dark = await rootBundle.loadString('assets/themes/map_dark.json');
  theme.themeDark = dark;

  if (prefs.getBool('isDarkTheme'))
    theme.setTheme(false);
  else
    theme.setTheme(true);
}
