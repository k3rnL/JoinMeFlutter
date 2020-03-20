import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:join_me/components/button.dart';
import 'package:join_me/components/list_item.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _avatar;

  void getImage() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((File image) {
      setState(() {
        _avatar = image;
      });
    });
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
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 225,
                  child: const Image(
                    image: AssetImage('assets/images/profilBackground.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    child: GestureDetector(
                      onTap: getImage,
                      child: CircleAvatar(
                          radius: 72,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                            AssetImage(_avatar == null ? '' : _avatar.path),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const ListItem(
              title: 'Fistname',
              subtitle: 'Hamilcar31',
            ),
            const ListItem(
              title: 'Lastname',
              subtitle: 'CERE / Gabriel',
            ),
            Container(
              height: 70,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'Phone',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '+33616228641',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
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

//void oui() {
//  showGeneralDialog<dynamic>(
//      barrierColor: Colors.black.withOpacity(0.5),
//      transitionBuilder: (BuildContext context, Animation<double> a1, Animation<double> a2, Widget widget) {
//        final double curvedValue = Curves.easeInOutBack.transform(
//            a1.value) - 1.0;
//        return Transform(
//          transform: Matrix4.translationValues(
//              0.0, curvedValue * 600, 0.0),
//          child: Opacity(
//            opacity: a1.value,
//            child: InsideAlertDialogProfil(
//              label: title,
//              hintTextProfil: subtitle,
//            ),
//          ),
//        );
//      },
//      transitionDuration: const Duration(milliseconds: 500),
//      barrierDismissible: true,
//      barrierLabel: '',
//      context: context,
//      pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) { return null;});
//}