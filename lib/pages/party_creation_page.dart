import 'package:flutter/material.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/contacts.dart';
import 'package:join_me/components/static_map.dart';
import 'package:join_me/components/text_input.dart';

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
            StaticMap(size: Size(MediaQuery.of(context).size.width, 200)),
            const Button(
              label: 'Confirm',
              onPressed: null,
            ),
            const Text(
              'Create your event !',
            ),
            const TextInput(hintText: 'Name your party !'),
            const SizedBox(height: 8),
            const TextInput(hintText: 'Search contact'),
            const Text(
              '0 contacts selected.',
            ),
            Contacts(),
          ],
        ),
      ),
    );
  }
}
