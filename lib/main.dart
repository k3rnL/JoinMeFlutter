import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:join_me/router.dart';
import 'package:join_me/themes/light.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'models/party.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<FirebaseAuth>(create: (BuildContext c) => FirebaseAuth.instance),
        Provider<FirebaseMessaging>(create: (BuildContext c) => FirebaseMessaging()),
        ListenableProvider<User>(create: (BuildContext c) => User()),
        ListenableProvider<Party>(create: (BuildContext c) => Party())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: Router.generateRoute,
        initialRoute: landingRoute,
        theme: buildLightTheme(),
      ),
    );
  }
}