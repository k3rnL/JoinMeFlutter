import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join_me/components/app_logo.dart';
import 'package:join_me/components/text_input.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/router.dart';
import 'package:join_me/services/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  AnimationController _animationController;
  Animation<double> _animation;
  String _verificationId;
  bool errorOccurred = false;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutSine);

    Future<void>.delayed(const Duration(seconds: 1), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: 220,
              margin: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Welcome to JoinMe !'),
                  if (_verificationId == null) ...buildPhoneInput(),
                  if (_verificationId != null) ...buildCodeInput(),
                ],
              ),
            ),
            Positioned.fill(
                child: IgnorePointer(
                    ignoring: true, child: AppLogo(animation: _animation)))
          ],
        ),
      ),
    );
  }

  List<Widget> buildPhoneInput() {
    return <Widget>[
      Text(errorOccurred ? errorMessage : 'Enter your phone number to login'),
      TextInput(
        error: errorOccurred,
        controller: _phoneController,
        hintText: '+33...',
      ),
      RaisedButton(
        child: const Text('Login'),
        onPressed: () => _tryLogin(_phoneController.text),
      )
    ];
  }

  List<Widget> buildCodeInput() {
    return <Widget>[
      Text(errorOccurred
          ? errorMessage
          : 'An SMS is sent to ${_phoneController.text}, enter the code below'),
      TextInput(
        error: errorOccurred,
        controller: _codeController,
        hintText: 'Verification code',
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            child: const Text('Change phone'),
            onPressed: () {
              setState(() {
                _verificationId = null;
                errorMessage = null;
                errorOccurred = false;
              });
            },
          ),
          RaisedButton(
            child: const Text('Verify'),
            onPressed: () => _verifyCode(_codeController.text),
          )
        ],
      )
    ];
  }

  void _tryLogin(String phone) {
    if (phone == null || phone == '') {
      setState(() {
        errorOccurred = true;
      });
    } else {
      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(minutes: 2),
          verificationCompleted: _verificationCompletedAutomatically,
          verificationFailed: _verificationFailed,
          codeSent: _codeSent,
          codeAutoRetrievalTimeout: null);
    }
  }

  Future<void> _verificationCompletedAutomatically(AuthCredential creds) async {
    final AuthResult result = await FirebaseAuth.instance.signInWithCredential(creds);
    await _finishLogin(result.user.uid);
    Navigator.of(context).pop();
    Navigator.of(context).popAndPushNamed(landingRoute);
  }

  void _verificationFailed(AuthException exception) {
    String msg = '';
    switch (exception.code) {
      case 'invalidCredential':
        msg =
            'Your phone number is incorrect, did you include your country code ?';
        break;
      default:
        msg = exception.message;
    }
    setState(() {
      errorOccurred = true;
      errorMessage = msg;
    });
  }

  void _codeSent(String verificationId, [int forceCodeResent]) {
    errorOccurred = false;
    errorMessage = null;
    setState(() {
      _verificationId = verificationId;
    });
  }

  Future<void> _verifyCode(String code) async {
    if (code != null && code != '') {
      final AuthCredential creds = PhoneAuthProvider.getCredential(
          verificationId: _verificationId, smsCode: code);
      final AuthResult result =
          await FirebaseAuth.instance.signInWithCredential(creds);

      if (result.user != null) {
        await _finishLogin(result.user.uid);
        Navigator.of(context).popAndPushNamed(landingRoute);
      }

      return;
    }

    setState(() {
      errorOccurred = true;
      errorMessage = 'The code entered is incorrect';
    });
  }
  
  Future<void> _finishLogin(String uid) async {
    User user = await ApiService.getUser(uid);

    // create account
    if (user == null) {
      user = User();
      user.uid = uid;
      user.phone = _phoneController.text;
      user.token = '';

      await ApiService.registerUser(user);
    }
  }
}
