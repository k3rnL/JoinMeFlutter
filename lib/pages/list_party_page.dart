import 'package:flutter/material.dart';
import 'package:join_me/models/party.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/services/api_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(ListPartyPage());

String horseUrl = 'https://i.imgur.com/NxyQI3b.png';
String cowUrl = 'https://i.stack.imgur.com/XPOr3.png';
String camelUrl = 'https://i.stack.imgur.com/YN0m7.png';
String sheepUrl = 'https://i.stack.imgur.com/wKzo8.png';
String goatUrl = 'https://i.stack.imgur.com/Qt4JP.png';

class ListPartyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiService.getUser(Provider.of<User>(context, listen: false).uid),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            final User user = snapshot.data;

            return ListView.builder(
                itemCount: user.invitations.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Text(
                      user.invitations[index]
                  );
                }
            );
          } else {
            if (snapshot.hasError) print(' salut = ' + snapshot.error);
            print('euhh');
            return Text("lol");
          }
        },
      ),
    );
  }
}
