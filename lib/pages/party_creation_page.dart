import 'package:flutter/material.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/contacts.dart';
import 'package:join_me/components/static_map.dart';
import 'package:join_me/components/text_input.dart';
import 'package:join_me/models/party.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/services/api_service.dart';
import 'package:provider/provider.dart';

Future<void> createEvent(BuildContext context, Party party) async {
  final String id = await ApiService.createParty(party.name, party.address);
  ApiService.addUsersToPartyByUid(<String>[Provider.of<User>(context, listen: false).uid], id);
}

class PartyCreationPage extends StatelessWidget {
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
            const SizedBox(height: 20,),
            Button(
              label: 'Confirm',
              onPressed: () => createEvent(context, Provider.of<Party>(context, listen: false)),
            ),
            const SizedBox(height: 10,),
            const Text(
              'Create your event !',
            ),
            const SizedBox(height: 10,),
            TextInput(
              hintText: 'Name your party !',
              onTextChanged: (String text) {
                Provider.of<Party>(context, listen: false).name = text;
              },
            ),
            const SizedBox(height: 20),
            const TextInput(hintText: 'Search contact'),
            const SizedBox(height: 10,),
            const Text(
              '0 contacts selected.',
            ),
            const SizedBox(height: 10,),

            Contacts(),
          ],
        ),
      ),
    );
  }
}
