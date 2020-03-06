import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:join_me/components/static_map.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class PartyCreationPage extends StatelessWidget {
  PartyCreationPage() {
    getContactsPermissions().then((bool value) {
      if (value) {
        //futureContacts = getContacts();
      }
    });
  }

  Future<List<Contact>> futureContacts = getContacts();

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
            const Text(
              '0 contacts selected.',
            ),


/*            FutureBuilder<List<Contact>>(
              future: futureContacts,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Contact>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: Center(child: Text('Entry')),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                } else {
                  return Text('Error' + snapshot.error.toString());
                }/* else {
                  return Text('Erro12r' + futureContacts.toString());
                }*/
              },
            ),*/



          ],
        ),
      ),
    );
  }
}

Future<bool> getContactsPermissions() async {
  final PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
  if (permission == PermissionStatus.denied) {
    await PermissionHandler().requestPermissions( <PermissionGroup> [PermissionGroup.contacts]);
  }
  if (permission == PermissionStatus.granted) {
    return true;
  }
  return false;
}

Future<List<Contact>> getContacts() async {
  final List<Contact> listContact = (await ContactsService.getContacts(withThumbnails: false)).toList();
  return listContact;
}
