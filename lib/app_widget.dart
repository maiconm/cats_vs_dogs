import 'package:cats_vs_dogs/modules/home/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cats vs Dogs",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
      },
    );
  }
}
