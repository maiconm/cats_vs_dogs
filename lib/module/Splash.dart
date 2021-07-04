import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Cats vs Dogs',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}