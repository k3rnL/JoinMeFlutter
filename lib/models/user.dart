import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:join_me/services/api_service.dart';

class User with ChangeNotifier {
  User();

  String uid;
  String phone;
  List<String> invitations;

  Future<void> retrieveData() async {
    final User user = await ApiService.getUser(uid);
    phone = user.phone;
    invitations = user.invitations;
  }

  dynamic toJson() =>
      // ignore: always_specify_types
      {
        'uid': uid,
        'phone': phone,
        'invitations': invitations,
      };

  static User fromJson(String json) {
    final Map<String, dynamic> object = jsonDecode(json);
    final User user = User();

    user.uid = object['id'];

    final List<dynamic> invitationsRaw = object['invitations'] as List<dynamic>;
    user.invitations = invitationsRaw
        .map<String>((dynamic obj) => obj['party_id'].toString())
        .toList();
    user.phone = object['phone'];
    return user;
  }
}
