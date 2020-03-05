import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join_me/router.dart';

void tryLogin(String phone, BuildContext context) {
  FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(minutes: 2),
      verificationCompleted: (AuthCredential creds) {
        print('Login success !');
        FirebaseAuth.instance.signInWithCredential(creds);
        Navigator.of(context).pushReplacementNamed(homeRoute);
      },
      verificationFailed: (AuthException exception) {
        print('Failed to login ! reason : ' + exception.message);
      },
      codeSent: null,
      codeAutoRetrievalTimeout: null);
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();


  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Login'),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              hintText: 'Phone',
            ),),
          const TextField(decoration: InputDecoration(
            hintText: 'Verification',
          ),),
          RaisedButton(
            child: const Text('Login'),
            onPressed: () => tryLogin(_phoneController.text, context),
          ),
        ],
      ),
    );
  }
}
