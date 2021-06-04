import 'package:cats_vs_dogs/components/card_widget.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_tindercard/flutter_tindercard.dart';

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

class CardsContainer extends StatefulWidget {
  const CardsContainer({ Key? key }) : super(key: key);

  @override
  _CardsContainerState createState() => _CardsContainerState();
}

class _CardsContainerState extends State<CardsContainer> with TickerProviderStateMixin {
  CardController controller = CardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  void likeHandler(CardSwipeOrientation side, int index) {
    if (side == CardSwipeOrientation.RIGHT) {
      print('liked');
    } else if (side == CardSwipeOrientation.LEFT) {
      print('disliked');
    }
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    data.shuffle();

    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
          minWidth: MediaQuery.of(context).size.width * 0.75,
          minHeight: MediaQuery.of(context).size.height * 0.6,
          cardBuilder: (context, index) => CardWidget(
            data[index]['imageUrl'],
            () => controller.triggerRight(),
          ),
          totalNum: data.length,
          cardController: controller,
          allowVerticalMovement: false,
          swipeCompleteCallback: (CardSwipeOrientation side, int index) => likeHandler(side, index),
        ),
      ),
    );
  }
}