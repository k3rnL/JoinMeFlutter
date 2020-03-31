import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:join_me/services/api_service.dart';

class User with ChangeNotifier {
  User();

  String uid;
  String phone;
  String picture;
  String firstName;
  String lastName;
  List<String> invitations;

  Future<void> retrieveData() async {
    final User user = await ApiService.getUser(uid);
    phone = user.phone;
    picture = user.picture;
    firstName = user.firstName;
    lastName = user.lastName;
    invitations = user.invitations;
    notifyListeners();
  }

  dynamic toJson() => <String, dynamic>{
        'uid': uid,
        'firstname': firstName,
        'lastname': lastName,
        'phone': phone,
        'picture': picture,
        'invitations': invitations,
      };

  static User fromJson(String json) {
    final Map<String, dynamic> object = jsonDecode(json);
    final User user = User();

    user.uid = object['id'];
    user.firstName = object['firstname'];
    user.lastName = object['lastname'];
    user.picture = object['picture'];

    final List<dynamic> invitationsRaw = object['invitations'] as List<dynamic>;
    user.invitations = invitationsRaw
        .map<String>((dynamic obj) => obj['party_id'].toString())
        .toList();
    user.phone = object['phone'];
    return user;
  }
}
