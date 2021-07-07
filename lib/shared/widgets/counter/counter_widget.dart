import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int number;
  final Color color;

  const CounterWidget({
    Key? key,
    required this.number,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 155,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
