import 'package:flutter/material.dart';
import 'package:join_me/components/alert_dialog_profile.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/list_item.dart';
import 'package:join_me/models/user.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 225,
                  child: const Image(
                    image: AssetImage('assets/images/profilBackground.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    child: GestureDetector(
                      child: CircleAvatar(
                          radius: 72,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                NetworkImage(Provider.of<User>(context).picture),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            ListItem(
              title: 'Fistname',
              subtitle: Provider.of<User>(context).firstName,
              onTap: () => oui(context, 'Firstname', Provider.of<User>(context, listen: false).firstName, (String value) {
                Provider.of<User>(context, listen: false).firstName = value;
              }),
            ),
            ListItem(
              title: 'Lastname',
              subtitle: Provider.of<User>(context).lastName,
                onTap: () => oui(context, 'Lastname', Provider.of<User>(context, listen: false).lastName, (String value) {
                  Provider.of<User>(context, listen: false).lastName = value;
                })
            ),
            ListItem(title: 'Phone', subtitle: Provider.of<User>(context).phone,),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Button(
                onPressed: null,
                label: 'Log out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void oui(BuildContext context, String fieldName, String hint, Function(String) valueChanged) {
  showGeneralDialog<dynamic>(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 600, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialogProfile(
              title: fieldName,
              hintText: hint,
              onValueChanged: valueChanged,
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation2) {
        return null;
      });
}
