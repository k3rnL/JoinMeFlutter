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
    lastName = user.lastName;
    firstName = user.firstName;
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
    return fromMap(jsonDecode(json));
  }

  static User fromMap(Map<String, dynamic> json) {
    final User user = User();

    user.uid = json['id'];
    user.firstName = json['firstname'];
    user.lastName = json['lastname'];
    user.picture = json['picture'];

    final List<dynamic> invitationsRaw = json['invitations'] as List<dynamic>;
    user.invitations = invitationsRaw
        .map<String>((dynamic obj) => obj['party_id'].toString())
        .toList();
    user.phone = json['phone'];
    return user;
  }
}
