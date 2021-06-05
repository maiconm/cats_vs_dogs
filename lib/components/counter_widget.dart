import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int _number;
  final MaterialColor _color;
  final String _type;

  CounterWidget(
    this._number,
    this._color,
    this._type,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.46,
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            _type == 'cat' ? '🐈 $_number' : '$_number 🐕',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      )
    );
  }
}