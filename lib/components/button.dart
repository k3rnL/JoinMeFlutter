import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7)
      buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class Button extends StatelessWidget {

  const Button({this.width = 200, this.height = 45, this.label, this.icon, this.onPressed, this.isError = false});

  final double height;
  final double width;
  final bool isError;
  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 10,
      fillColor: isError == true ? Theme.of(context).errorColor : Theme.of(context).primaryColor,
      splashColor: Theme.of(context).primaryColorLight,
      highlightColor: Theme.of(context).primaryColorDark,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: width, height: height),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (icon != null) icon else Container(),
              if (icon != null) const SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Center(
                      child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentTextTheme.body1.color
                ),
              )))
            ],
          ),
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
