import 'package:flutter/material.dart';
import 'package:join_me/models/party.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/router.dart';
import 'package:join_me/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:join_me/components/list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      body: FutureBuilder<User>(
        future:
            ApiService.getUser(Provider.of<User>(context, listen: false).uid),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            final User user = snapshot.data;

            return ListView.builder(
                itemCount: user.invitations.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Slidable(
                    actionPane: const SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: FutureBuilder<Party>(
                      future: ApiService.getParty(user.invitations[index]),
                      builder: (BuildContext context,
                          AsyncSnapshot<Party> snapshot) {
                        if (snapshot.hasData) {
                          final Party party = snapshot.data;
                          final String nbMembersString =
                              party.members.length.toString() + ' members';
                          final String encoded = Uri.encodeFull(party.address);

                          return Column(
                            children: <Widget>[
                             ListItem(
                                image: NetworkImage(
                                    'https://maps.googleapis.com/maps/api/staticmap?center=$encoded&zoom=13&size=1800x1800&maptype=roadmap&markers=color:blue%7C$encoded&key=AIzaSyAfv8IPCxhiURtrI8tDyQptGEVQoOl0G3c'),
                                title: party.name,
                                subtitle: nbMembersString,
                                onTap: () {
                                  Provider.of<Party>(context, listen: false)
                                      .members = party.members;
                                  Provider.of<Party>(context, listen: false)
                                      .id = party.id;
                                  Provider.of<Party>(context, listen: false)
                                      .address = party.address;
                                  Provider.of<Party>(context, listen: false)
                                      .name = party.name;
                                  Navigator.of(context).pushNamed(partyDetail);
                                },
                              ),
                            ],
                          );
                        } else {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          return const Text('');
                        }
                      },
                    ),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => print('Delete'),
                      ),
                    ],
                  );
                });
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return const Text('');
          }
        },
      ),
    );
  }
}
