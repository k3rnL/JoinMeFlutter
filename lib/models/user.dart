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
    invitations = user.invitations;
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

    print(json);
    user.uid = object['id'];
    user.firstName = object['firstname'];
    user.lastName = object['lastname'];
    print(user.firstName);

    final List<dynamic> invitationsRaw = object['invitations'] as List<dynamic>;
    user.invitations = invitationsRaw
        .map<String>((dynamic obj) => obj['party_id'].toString())
        .toList();
    user.phone = object['phone'];
    return user;
  }
}
