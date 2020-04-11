import 'dart:convert';
import 'dart:io';

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

  static Future<void> addUsersToParty(
      List<String> phones, String partyId) async {
    final List<User> users = phones.map((String phone) {
      final User user = User();
      user.phone = phone;
      return user;
    }).toList();
    final http.Response response = await http.patch(
        API_URL + '/party/' + partyId.toString(),
        body: jsonEncode(users));
    if (response.statusCode == 200) {
      print('addUsersToParty Response body: ${response.body}');
    }
  }

  static Future<void> addUsersToPartyByUid(
      List<String> uids, String partyId) async {
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

  static Future<bool> registerUser(User user) async {
    final http.Response response =
        await http.post(API_URL + '/users/register', body: jsonEncode(user));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> updateUserToken(String uid, String fcmToken) async {
    final http.Response response = await http.patch(
        API_URL + '/users/' + uid + '/token',
        body: jsonEncode(<String, dynamic>{'fcm_token': fcmToken}));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<User> getUser(String uid) async {
    final http.Response response = await http.get(API_URL + '/users/' + uid);
    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    }
    return null;
  }

  static Future<List<Party>> getInvitations(String uid) async {
    final http.Response response = await http.get(API_URL + '/users/$uid/invitations');
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Stream<dynamic>.fromIterable(json.values)
          .asyncMap<Party>((dynamic party) => Party.fromMap(
              json: party as Map<String, dynamic>,
              retrieveInvitationsFromApi: false))
          .toList();
    }
    return null;
  }

  static Future<Party> getParty(String id) async {
    final http.Response response = await http.get(API_URL + '/party/' + id);
    if (response.statusCode == 200) {
      return Party.fromJson(json: response.body);
    }
    return null;
  }

  static Future<void> unsubscribeToParty(String uid, String partyId) async {
    final http.Response response =
        await http.delete(API_URL + '/users/' + uid + '/' + partyId);
    if (response.statusCode == 200) {
      print('unsubscribeToParty Response body: ${response.body}');
    }
  }

  static Future<bool> updateUserInfo(User user) async {
    final http.Response response = await http
        .patch(API_URL + '/users/' + user.uid, body: jsonEncode(user));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> updateProfilePicture(
      File imageProfile, String uid) async {
    // open a bytestream
    final http.ByteStream stream = http.ByteStream(imageProfile.openRead());
    // get file length
    final int length = await imageProfile.length();

    // string to uri
    final Uri uri = Uri.parse(API_URL + '/users/' + uid + '/picture');

    // create multipart request
    final http.MultipartRequest request = http.MultipartRequest('POST', uri);

    // multipart that takes file
    final http.MultipartFile multipartFile = http.MultipartFile(
        'picture', stream, length,
        filename: imageProfile.path);

    // add file to multipart
    request.files.add(multipartFile);
    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {}
    return false;
  }
}
