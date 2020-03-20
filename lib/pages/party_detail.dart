import 'package:flutter/material.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/rowProfil.dart';
import 'package:join_me/components/static_map.dart';
import 'package:join_me/models/party.dart';
import 'package:join_me/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PartyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Party>(
        future: ApiService.getParty('96127753'),
        builder: (BuildContext context, AsyncSnapshot<Party> snapshot) {
          if (snapshot.hasData) {
            final Party party = snapshot.data;

            return Column(
              children: <Widget>[
                StaticMap(
                  address: party.address,
                  size: Size(MediaQuery.of(context).size.width, 250),
                ),
                Button(
                    label: 'Go to this party !',
                    onPressed: () {
                      launch(generateGoogleMapsUrl(party));
                    }),
                Expanded(
                  child: ListView.builder(
                    itemCount: party.members.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RowProfil(
                        label: party.members[index].phone,
                        hintTextProfil: '',
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            if (snapshot.hasError)
              print(snapshot.error);
            return const Text('lol');
          }
        },
      ),
    );
  }

  String generateGoogleMapsUrl(Party party) {
    return 'https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeFull(party.address)}';
  }
}
