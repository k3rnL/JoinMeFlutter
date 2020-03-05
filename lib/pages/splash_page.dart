import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import '../home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  dynamic initState() {
    FirebaseAuth.instance.currentUser().then((dynamic currentUser) {
      if (currentUser == null)
        Navigator.pushReplacementNamed(context, '/login');
      else
        Firestore.instance
            .collection('users')
            .document(currentUser.uid)
            .get()
            .then<dynamic>(
                (DocumentSnapshot result) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (dynamic context) => HomePage(
                              uid: currentUser.uid,
                            ))))
            .catchError((dynamic err) => print(err));
    }).catchError((dynamic err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlareActor('assets/animations/loading_circle.flr',
            animation: 'Untitled', color: Colors.red),
      ),
    );
  }
}
