import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/router.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  dynamic initState() {
    tryConnect();
    super.initState();
  }

  void tryConnect() {
    FirebaseAuth.instance.currentUser().then((dynamic currentUser) {
      if (currentUser == null)
        Navigator.pushReplacementNamed(context, loginRoute);
      else {
        Firestore.instance
            .collection('users')
            .document(currentUser.uid)
            .get()
            .then<dynamic>((DocumentSnapshot result) {
          Provider.of<User>(context, listen: false).uid = currentUser.uid;
          Navigator.pushNamed(context, homeRoute);
        }).catchError((dynamic err) => print(err));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
            child: FlareActor('assets/animations/loading_circle.flr',
                animation: 'Untitled', color: Theme.of(context).primaryColor),
      ),
    );
  }
}
