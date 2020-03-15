import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:join_me/models/party.dart';
import 'package:join_me/models/user.dart';

class ApiService {
  ApiService();

  static const String API_URL = 'https://join-me-api.herokuapp.com';

  static Future<String> createParty(String name, String address) async {
    final Party party = Party();
    party.name = name;
    party.address = address;
    final http.Response response =
        await http.post(API_URL + '/party/create', body: jsonEncode(party));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return json['id'].toString();
    }
    return '';
  }

  static Future<void> addUsersToParty(List<String> phones, int partyId) async {
    final List<User> users = <User>[];
    for (String phone in phones) {
      final User user = User();
      user.phone = phone;
      users.add(user);
    }
    final http.Response response = await http.patch(
        API_URL + '/party/' + partyId.toString(),
        body: jsonEncode(users));
    if (response.statusCode == 200) {
      print('addUsersToParty Response body: ${response.body}');
    }
  }

  static Future<void> addUsersToPartyByUid(List<String> uids, String partyId) async {
    final List<User> users = uids.map<User>((String uid) {
      final User user = User();
      user.uid = uid;
      return user;
    }).toList();

    final http.Response response = await http.patch(
        API_URL + '/party/' + partyId.toString(),
        body: jsonEncode(users));
    if (response.statusCode == 200) {
      print('addUsersToParty Response body: ${response.body}');
    }
  }

  static Future<void> registerUser(String uid, String fcmToken) async {
    final http.Response response = await http.post(
        API_URL + '/users/' + uid + '/update_token',
        body: <String, dynamic>{'fcm_token': fcmToken});
    if (response.statusCode == 200) {
      print('registerUser Response body: ${response.body}');
    }
  }

  static Future<void> updateUserToken(String uid, String fcmToken) async {
    final http.Response response = await http.patch(
        API_URL + '/users/' + uid + '/update_token',
        body: <String, dynamic>{'fcm_token': fcmToken});
    if (response.statusCode == 200) {
      print('updateUserToken Response body: ${response.body}');
    }
  }

  static Future<User> getUser(String uid) async {
    final http.Response response = await http.get(API_URL + '/users/' + uid);
    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    }
    return null;
  }

  static Future<Party> getParty(int id) async {
    final http.Response response =
        await http.get(API_URL + '/party/' + id.toString());
    if (response.statusCode == 200) {
      print('getParty Response body: ${response.body}');
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<void> unsubscribeToParty(String uid, int partyId) async {
    final http.Response response = await http.get(API_URL + '/users/' + uid);
    if (response.statusCode == 200) {
      print('unsubscribeToParty Response body: ${response.body}');
    }
  }
}
