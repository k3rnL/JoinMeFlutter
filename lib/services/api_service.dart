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
      print('Response body: ${response.body}');
    }
  }

  Future<void> addUsersToParty(List<String> phones, int partyId) async {
    final List<User> users = [];
    for (String phone in phones) {
      final User user = User();
      user.phone = phone;
      users.add(user);
    }
    final http.Response response = await http.patch(url + '/party/' + partyId.toString(), body: jsonEncode(users));
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
    }
  }

}
