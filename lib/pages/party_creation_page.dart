import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
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
  await ApiService.addUsersToPartyByUid(
      <String>[Provider.of<User>(context, listen: false).uid], id);

  final List<String> phoneNumberToAdd = selectedContact.map<String>((Contact c) => c.phones.first.value).toList();
  await ApiService.addUsersToParty(phoneNumberToAdd, id);

  final Party partyAfter = await ApiService.getParty(id);
  Provider.of<Party>(context, listen: false).setData(partyAfter);

  Navigator.of(context).popAndPushNamed(partyDetail);
}

class PartyCreationPage extends StatefulWidget {
  @override
  _PartyCreationPageState createState() => _PartyCreationPageState();
}

class _PartyCreationPageState extends State<PartyCreationPage> {
  List<Contact> selectedContact;
  String filter;
  bool isCreatingParty;

  @override
  void initState() {
    super.initState();
    selectedContact = <Contact>[];
    filter = '';
    isCreatingParty = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StaticMap(
                address: Provider.of<Party>(context).address,
                size: Size(MediaQuery.of(context).size.width, 250)),
            const SizedBox(
              height: 20,
            ),
            ..._buildConfirmButton(context),
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
            SizedBox(
              height: 200,
              child: Contacts(
                filter: filter,
                selectedContactsChanged: (List<Contact> l) {
                  setState(() {
                    selectedContact = l;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildConfirmButton(BuildContext context) {
    return <Widget>[
      if (!isCreatingParty) Button(
        label: 'Confirm',
        onPressed: () {
          setState(() {
            isCreatingParty = true;
          });
          final String name = Provider.of<Party>(context, listen: false).name;
          if (name == null || name == '') {
            Provider.of<Party>(context, listen: false).name = 'My party';
          }
          createEvent(
              context, Provider.of<Party>(context, listen: false),
              selectedContact);
        },
      ) else Container(height: 48,child: const Center(child: CircularProgressIndicator()))
    ];
  }
}
