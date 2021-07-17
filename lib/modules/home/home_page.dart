import 'package:cats_vs_dogs/shared/widgets/counter/counter_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var numOne = 4;
  final numTwo = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CounterWidget(
                  number: numOne,
                  color: Colors.red,
                ),
                CounterWidget(
                  number: numTwo,
                  color: Colors.blue,
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  numOne++;
                });
              },
              child: Text("test")
            )
          ],
        ),
      ),
    );
  }
}
