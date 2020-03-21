import 'package:flutter/material.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/list_item.dart';
import 'package:join_me/components/static_map.dart';
import 'package:join_me/models/party.dart';
import 'package:join_me/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PartyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Party party = Provider.of<Party>(context, listen: false);

    return Scaffold(
      body: Column(
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
                      return ListItem(
                        title: party.members[index].phone,
                        subtitle: '',
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  String generateGoogleMapsUrl(Party party) {
    return 'https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeFull(party.address)}';
  }
}
