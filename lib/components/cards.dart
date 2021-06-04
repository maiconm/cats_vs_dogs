import 'package:flutter/material.dart';
import 'card_container.dart';

final List data = [
  {
    'imageUrl': 'lib/assets/bored-cat.jpeg',
  },
  {
    'imageUrl': 'lib/assets/dog-running.jpeg',
  },
  {
    'imageUrl': 'lib/assets/doggy.jpg',
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
      data[0]['imageUrl']
    ),
    CardContainer(
      data[1]['imageUrl']
    ),
    CardContainer(
      data[2]['imageUrl']
    ),
  ];

  @override
  Widget build(BuildContext context) {
    cards.shuffle();
    return Container(
      height: 300,
      width: 300,
      child: Stack(
        children: cards,
      ),
    );
  }
}
