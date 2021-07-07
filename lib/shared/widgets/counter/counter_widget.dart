import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 155,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text(
          "0",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
