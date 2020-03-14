import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  User();

  String uid;
  String phone;
  List<int> invitations;

  dynamic toJson() =>
      // ignore: always_specify_types
  {
    'uid': uid,
    'phone': phone,
    'invitations': invitations,
  };

}