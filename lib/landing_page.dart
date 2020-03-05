import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
//return Scaffold(
//backgroundColor: Colors.white10,
//body: Center(
//child: FlareActor("assets/animations/loading_circle.flr",
//animation: 'Untitled', color: Colors.red),

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = Provider.of<FirebaseAuth>(context);

    return Text('oui');
//    return StreamBuilder<FirebaseUser>(
//        stream: firebaseAuth.onAuthStateChanged,
//        builder: (BuildContext context, AsyncSnapshot snapshot) {
//          Widget finalWidget = null;
//          if (snapshot.connectionState == ConnectionState.active) {
//            FirebaseUser user = snapshot.data;
////            if (user == null)
////              Navigator.of(context).pushReplacementNamed(authRoute);
////            else
////              Navigator.of(context).pushReplacementNamed(homeRoute);
//            return HomePage();
//          }
//
//            ),
//        });
  }
}
