import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/services/api_service.dart';

class Party with ChangeNotifier {
  Party();

  int id;
  String name;
  String address;
  List<User> members;

  void setData(Party party) {
    id = party.id;
    name = party.name;
    address = party.address;
    members = party.members;
    notifyListeners();
  }

  dynamic toJson() =>
      // ignore: always_specify_types
      {
        'name': name,
        'id': id,
        'address': address,
        'members': members,
      };

  static Future<Party> fromJson(
      {String json, bool retrieveInvitationsFromApi = true}) async {
    return fromMap(json: jsonDecode(json), retrieveInvitationsFromApi: retrieveInvitationsFromApi);
  }

  static Future<Party> fromMap(
      {Map<String, dynamic> json, bool retrieveInvitationsFromApi = true}) async {

    final Party party = Party();

    party.id = json['id'];
    party.name = json['name'];
    party.address = json['address'];

    if (retrieveInvitationsFromApi) {
      final List<dynamic> invitationsRaw = json['members'] as List<dynamic>;
      party.members = await Stream<dynamic>.fromIterable(invitationsRaw)
          .asyncMap((dynamic obj) => ApiService.getUser(obj['uid']))
          .toList();
    } else {
      party.members = (json['members'] as List<dynamic>)
          .map<User>((dynamic user) => User.fromMap(user)).toList();
    }

    return party;
  }


}
