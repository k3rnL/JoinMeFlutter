import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:join_me/router.dart';
import 'package:join_me/themes/dark.dart';
import 'package:join_me/themes/light.dart';
import 'package:join_me/themes/map_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'models/party.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<FirebaseAuth>(create: (BuildContext c) => FirebaseAuth.instance),
        Provider<FirebaseMessaging>(create: (BuildContext c) => FirebaseMessaging()),
        ListenableProvider<User>(create: (BuildContext c) => User()),
        ListenableProvider<Party>(create: (BuildContext c) => Party()),
        ChangeNotifierProvider<MapTheme>(create: (BuildContext c) => MapTheme())
      ],
      child: Consumer<MapTheme>(
        builder: (BuildContext context, MapTheme theme, Widget w){
          return MaterialApp(
            title: 'JoinMe',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Router.generateRoute,
            initialRoute: landingRoute,
            theme: theme.theme != theme.themeLight ? buildLightTheme() : buildDarkTheme(),
            themeMode: ThemeMode.dark,
          );
        },
      ),
    );
  }
}