import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final int _number;
  final MaterialColor _color;
  final String _type;

  CounterWidget(
    this._number,
    this._color,
    this._type,
  );

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget._color,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.46,
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            widget._type == 'cat' ? '🐈 ${widget._number}' : '${widget._number} 🐕',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      )
    );
  }
}
