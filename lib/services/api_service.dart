import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:join_me/models/party.dart';
import 'package:join_me/models/user.dart';

class ApiService {
  ApiService();

  String url = 'https://join-me-api.herokuapp.com';

  Future<void> createParty(String name, String address) async {
    final Party party = Party();
    party.name = name;
    party.address = address;
    final http.Response response = await http.post(url + '/party/create', body: jsonEncode(party));
    if (response.statusCode == 200) {
      print('createParty Response body: ${response.body}');
    }
  }

  Future<void> addUsersToParty(List<String> phones, int partyId) async {
    final List<User> users = <User> [];
    for (String phone in phones) {
      final User user = User();
      user.phone = phone;
      users.add(user);
    }
    final http.Response response = await http.patch(url + '/party/' + partyId.toString(), body: jsonEncode(users));
    if (response.statusCode == 200) {
      print('addUsersToParty Response body: ${response.body}');
    }
  }

  Future<void> registerUser(String uid, String fcmToken) async {
    final http.Response response = await http.post(url + '/users/' + uid + '/update_token',  body: <String, dynamic> {'fcm_token': fcmToken});
    if (response.statusCode == 200) {
      print('registerUser Response body: ${response.body}');
    }
  }

  Future<void> updateUserToken(String uid, String fcmToken) async {
    final http.Response response = await http.patch(url + '/users/' + uid + '/update_token', body: <String, dynamic> {'fcm_token': fcmToken});
    if (response.statusCode == 200) {
      print('updateUserToken Response body: ${response.body}');
    }
  }

  Future<User> getUser(String uid) async {
    final http.Response response = await http.get(url + '/users/' + uid);
    if (response.statusCode == 200) {
      print('getUser Response body: ${response.body}');
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<Party> getParty(int id) async {
    final http.Response response = await http.get(url + '/party/' + id.toString());
    if (response.statusCode == 200) {
      print('getParty Response body: ${response.body}');
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<void> unsubscribeToParty(String uid, int partyId) async {
    final http.Response response = await http.get(url + '/users/' + uid);
    if (response.statusCode == 200) {
      print('unsubscribeToParty Response body: ${response.body}');
    }
  }
}
