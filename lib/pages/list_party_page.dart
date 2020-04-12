import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:join_me/models/party.dart';
import 'package:join_me/models/user.dart';
import 'package:join_me/router.dart';
import 'package:join_me/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:join_me/components/list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListPartyPage extends StatefulWidget {
  const ListPartyPage({Key key}) : super(key: key);

  @override
  _ListPartyPage createState() => _ListPartyPage();
}

class _ListPartyPage extends State<ListPartyPage> {
  List<Party> parties;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _handleRefresh,
      child: parties == null ? _buildLoading(context) : _buildList(context),
    ));
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        itemCount: parties.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final Party party = parties[index];
          final String nbMembersString =
              party.members.length.toString() + ' members';
          final String encoded = Uri.encodeFull(party.address);
          return Slidable(
            key: Key(index.toString()),
            actionPane: const SlidableDrawerActionPane(),
            child: Column(
              children: <Widget>[
                ListItem(
                  image: NetworkImage(
                      'https://maps.googleapis.com/maps/api/staticmap?center=$encoded&zoom=13&size=180x180&maptype=roadmap&markers=color:blue%7C$encoded&key=AIzaSyAfv8IPCxhiURtrI8tDyQptGEVQoOl0G3c'),
                  title: party.name,
                  subtitle: nbMembersString,
                  onTap: () {
                    Provider.of<Party>(context, listen: false).setData(party);
                    Navigator.of(context).pushNamed(partyDetail);
                  },
                ),
              ],
            ),
            actions: <Widget>[
              IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    ApiService.unsubscribeToParty(
                        Provider.of<User>(context, listen: false).uid,
                        parties[index].id.toString());
                    setState(() {
                      parties.removeAt(index);
                    });
                  }),
            ],
          );
        });
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Future<void> _handleRefresh() async {
    final List<Party> parties = await _getParties();
    setState(() {
      this.parties = parties;
    });
  }

  Future<List<Party>> _getParties() async {
    final User user = Provider.of<User>(context, listen: false);
    return await ApiService.getInvitations(user.uid);
  }
}
