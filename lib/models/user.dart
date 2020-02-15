class User {
  User();

  String uid;
  String phone;
  List<int> invitations;

  dynamic toJson() =>
      // ignore: always_specify_types
  {
    'uid': uid,
    'phone': phone,
    'invitations': invitations,
  };

}