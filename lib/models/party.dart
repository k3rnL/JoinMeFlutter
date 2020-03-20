import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/services/api_service.dart';

class Party with ChangeNotifier {
  Party();

  String name;
  int id;
  String address;
  List<User> members;

  dynamic toJson() =>
      // ignore: always_specify_types
      {
        'name': name,
        'id': id,
        'address': address,
        'members': members,
      };

  static Future<Party> fromJson(String json) async {
    final Map<String, dynamic> object = jsonDecode(json);
    final Party party = Party();

    party.id = object['id'];
    party.name = object['name'];
    party.address = object['address'];

    final List<dynamic> invitationsRaw = object['members'] as List<dynamic>;
    party.members = await Stream<dynamic>.fromIterable(invitationsRaw)
        .asyncMap((dynamic obj) => ApiService.getUser(obj['uid']))
        .toList();

    return party;
  }
}
