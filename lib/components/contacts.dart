import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatefulWidget {
  const Contacts({this.selectedContactsChanged, this.filter = ''});

  final Function(List<Contact>) selectedContactsChanged;
  final String filter;

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  @override
  void initState() {
    super.initState();
    selectedContacts = <String, bool>{};
  }

  Map<String, Contact> contacts;
  Map<String, bool>  selectedContacts;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getContactsPermissions(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

        // Show errors
        if (snapshot.hasError || !snapshot.hasData)
          return const Text('Something went wrong when accessing your contacts');
        else if (!snapshot.data)
          return const Text('Please allow the app to access your contacts');

        return FutureBuilder<List<Contact>>(
            future: getContacts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
              if (snapshot.hasData) {
                contacts = Map<String, Contact>.fromIterable(snapshot.data, key: (dynamic c) => c.identifier, value: (dynamic c) => c);
                List<Contact> filtered = contacts.values.where((Contact c) {
                  return c.displayName.toLowerCase().contains(widget.filter.toLowerCase());
                }).toList();
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filtered.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Contact contact = filtered[index];
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 30),
                                Checkbox(onChanged: (bool value) {
                                  final List<Contact> list = <Contact>[];
                                  selectedContacts[contact.identifier] = value;
                                  selectedContacts.forEach((String id, bool selected) {
                                    if (selected)
                                      list.add(contacts[id]);
                                  });
                                  widget.selectedContactsChanged(list);
                                  print(list.runtimeType);
                                  setState(() {
                                    selectedContacts[contact.identifier] = value;
                                  });
                                }, value: selectedContacts[contact.identifier] == null ? false : selectedContacts[contact.identifier],),
                                const SizedBox(width: 30),
                                Text(contact.displayName),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return Text('Error' + snapshot.error.toString());
              }
            });
      },
    );
  }

}

Future<bool> getContactsPermissions() async {
  final PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
  if (permission == PermissionStatus.denied) {
    await PermissionHandler()
        .requestPermissions(<PermissionGroup>[PermissionGroup.contacts]);
  }
  if (permission == PermissionStatus.granted) {
    return true;
  }
  return false;
}

Future<List<Contact>> getContacts() async {
  final List<Contact> listContact =
      (await ContactsService.getContacts(withThumbnails: false)).toList();
  return listContact;
}
