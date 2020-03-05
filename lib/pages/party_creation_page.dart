import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:join_me/components/static_map.dart';
import 'package:permission_handler/permission_handler.dart';

class PartyCreationPage extends StatelessWidget {
  PartyCreationPage() {
    getContactsPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StaticMap(size: Size(MediaQuery.of(context).size.width, 200)),
            const RaisedButton(
              onPressed: null,
              child: Text(
                'Confirm',
              ),
            ),
            const Text(
              'Create your event !',
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Name your party !',
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search for contacts',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

Future<void> getContactsPermissions() async {
  PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
  if (permission == PermissionStatus.denied) {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
  }
  if (permission == PermissionStatus.granted) {
    getContacts();
  }
}

Future<void> getContacts() async {
  Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
    for (var contact in contacts) {
      print('name = ' + contact.displayName);
    }
}