import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/router.dart';
import 'package:join_me/services/api_service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  dynamic initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2), init);
  }

  Future<void> init() async {
//    await initNotifications();
    final bool isConnected = await tryConnect();

    if (isConnected) {
      // update user token
      final String fcmToken =
          await Provider.of<FirebaseMessaging>(context, listen: false).getToken();
      await ApiService.updateUserToken(
          Provider.of<User>(context, listen: false).uid, fcmToken);

      Navigator.pushReplacementNamed(context, homeRoute);

    } else {
      Navigator.pushReplacementNamed(context, loginRoute);
    }
  }

  static Future<void> backgroundMessageHandler(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
//      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
//      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  Future<void> initNotifications() async {
    await Provider.of<FirebaseMessaging>(context, listen: false)
        .requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    Provider.of<FirebaseMessaging>(context, listen: false).configure(
      onMessage: (Map<String, dynamic> message) async {
      },
      onBackgroundMessage: backgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
      },
      onResume: (Map<String, dynamic> message) async {
      },
    );
  }

  Future<bool> tryConnect() async {
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser == null) {
      Navigator.pushReplacementNamed(context, loginRoute);
      return false;
    } else {
      final DocumentSnapshot userDoc = await Firestore.instance
          .collection('users')
          .document(currentUser.uid)
          .get();

      Provider.of<User>(context, listen: false).uid = userDoc.data['id'];
      Provider.of<User>(context, listen: false).phone = userDoc.data['phone'];
      Provider.of<User>(context, listen: false).picture = userDoc.data['picture'];
      Provider.of<User>(context, listen: false).firstName = userDoc.data['firstname'];
      Provider.of<User>(context, listen: false).lastName = userDoc.data['lastname'];
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlareActor('assets/animations/loading_circle.flr',
            animation: 'Untitled', color: Theme.of(context).primaryColor),
      ),
    );
  }
}
