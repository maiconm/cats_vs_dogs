import 'package:flutter/material.dart';
import 'card_container.dart';

final List data = [
  {
    'color': Colors.red,
  },
  {
    'color': Colors.blue,
  },
  {
    'color': Colors.green,
  },
];

class Cards extends StatefulWidget {
  const Cards({ Key? key }) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  List<CardContainer> cards = [
    CardContainer(
      data[0]['color']
    ),
    CardContainer(
      data[1]['color']
    ),
    CardContainer(
      data[2]['color']
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 600,
      child: Stack(
        children: cards,
      ),
    );
  }
}
