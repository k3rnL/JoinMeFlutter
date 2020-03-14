import 'package:flutter/material.dart';
import 'package:join_me/components/InsideAlertDialogProfil.dart';


class RowProfil extends StatelessWidget {
  const RowProfil({this.label, this.hintTextProfil,});

final String label;
final String hintTextProfil;

@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          showGeneralDialog<dynamic>(
              barrierColor: Colors.black.withOpacity(0.5),
              transitionBuilder: (BuildContext context, Animation<double> a1, Animation<double> a2, Widget widget) {
                final double curvedValue = Curves.easeInOutBack.transform(
                    a1.value) - 1.0;
                return Transform(
                  transform: Matrix4.translationValues(
                      0.0, curvedValue * 600, 0.0),
                  child: Opacity(
                    opacity: a1.value,
                    child: InsideAlertDialogProfil(
                      label: label,
                      hintTextProfil: hintTextProfil,
                    ),
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 500),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
              pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) { return null;}),
      child: Container(
        height: 70,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                label,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                hintTextProfil,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}