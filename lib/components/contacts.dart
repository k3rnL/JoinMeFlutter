import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatelessWidget {
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
                final List<Contact> contact = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 30),
                                Checkbox(onChanged: (bool value) {}, value: false,),
                                const SizedBox(width: 30),
                                Text(contact[index].displayName),
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
