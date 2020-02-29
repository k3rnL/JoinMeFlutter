class Party {
  Party();

  String name;
  int number;
  String address;
  List<String> members;


  dynamic toJson() =>
      // ignore: always_specify_types
      {
        'name': name,
        'number': number,
        'address': address,
        'members': members,
      };
}