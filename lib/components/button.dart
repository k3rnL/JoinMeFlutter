import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
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
  const Button({this.label, this.icon, this.onPressed});

  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 10,
      fillColor: Theme.of(context).primaryColor,
      splashColor: Theme.of(context).primaryColorLight,
      highlightColor: Theme.of(context).primaryColorDark,
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 200, height: 45),
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
                  color: Colors.white,
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
