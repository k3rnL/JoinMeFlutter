import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/contacts.dart';
import 'package:join_me/components/static_map.dart';
import 'package:join_me/components/text_input.dart';
import 'package:join_me/models/party.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/router.dart';
import 'package:join_me/services/api_service.dart';
import 'package:provider/provider.dart';

Future<void> createEvent(BuildContext context, Party party, List<Contact> selectedContact) async {
  final String id = await ApiService.createParty(party.name, party.address);
  ApiService.addUsersToPartyByUid(
      <String>[Provider.of<User>(context, listen: false).uid], id);

  final Party partyAfter = await ApiService.getParty(id);
  print(selectedContact.runtimeType);
  final List<String> phoneNumberToAdd = selectedContact.map<String>((Contact c) => c.phones.first.value).toList();
  ApiService.addUsersToParty(phoneNumberToAdd, id);

  Provider.of<Party>(context, listen: false).members = partyAfter.members;
  Provider.of<Party>(context, listen: false).id = partyAfter.id;
  Provider.of<Party>(context, listen: false).address = partyAfter.address;
  Provider.of<Party>(context, listen: false).name = partyAfter.name;
//  Navigator.of(context).popAndPushNamed(partyDetail);
}

class PartyCreationPage extends StatefulWidget {
  @override
  _PartyCreationPageState createState() => _PartyCreationPageState();
}

class _PartyCreationPageState extends State<PartyCreationPage> {
  List<Contact> selectedContact;
  String filter;

  @override
  void initState() {
    super.initState();
    selectedContact = <Contact>[];
    filter = '';
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
            StaticMap(
                address: Provider.of<Party>(context).address,
                size: Size(MediaQuery.of(context).size.width, 250)),
            const SizedBox(
              height: 20,
            ),
            Button(
              label: 'Confirm',
              onPressed: () {
                print("coucou");
                print(selectedContact.runtimeType);
                print(selectedContact);
                createEvent(
                    context, Provider.of<Party>(context, listen: false),
                    selectedContact);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Create your event !',
            ),
            const SizedBox(
              height: 10,
            ),
            TextInput(
              hintText: 'Name your party !',
              onTextChanged: (String text) {
                Provider.of<Party>(context, listen: false).name = text;
              },
            ),
            const SizedBox(height: 20),
            TextInput(
              hintText: 'Search contact',
              onTextChanged: (String v) {
                setState(() {
                  filter = v;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${selectedContact.length} contacts selected.',
            ),
            const SizedBox(
              height: 10,
            ),
            Contacts(
              filter: filter,
              selectedContactsChanged: (List<Contact> l) {
                setState(() {
                  selectedContact = l;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
