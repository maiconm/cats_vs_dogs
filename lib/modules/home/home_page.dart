import 'package:cats_vs_dogs/shared/widgets/counter/counter_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CounterWidget(number: 3, color: Colors.red,),
            CounterWidget(number: 5, color: Colors.blue,),
          ],
        ),
      ),
    );
  }
}
