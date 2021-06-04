import 'package:cats_vs_dogs/components/card_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final String dogAsApi = 'https://dog.ceo/api/breeds/image/random';
final String ramdomCatApi = 'https://aws.random.cat/meow';
final String firebaseUrl = '';

class CardsContainer extends StatefulWidget {
  const CardsContainer({ Key? key }) : super(key: key);

  @override
  _CardsContainerState createState() => _CardsContainerState();
}

class _CardsContainerState extends State<CardsContainer> with TickerProviderStateMixin {
  CardController controller = CardController();
  List images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  @override
  void initState() {
    getThreeInitialImages().then(
      (initialImages) {
        setState(() {
          initialImages.forEach((image) {
            images.add(image);
          });
        });
      }
    );
    super.initState();
  }

  Future<List> getThreeInitialImages() async {
    var first = await requestNewImage(true);
    var second = await requestNewImage(true);
    var third = await requestNewImage(true);
    var fourth = await requestNewImage(false);
    var fifth = await requestNewImage(false);
    var sixth = await requestNewImage(false);
    return [first, second, third, fourth, fifth, sixth];
  }

  Future<String> requestNewImage(bool isDog) async {
    var url = Uri.parse(isDog ? dogAsApi : ramdomCatApi);
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse[isDog ? 'message' : 'file'];
  }

  void likeHandler(CardSwipeOrientation side) async {
    DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('dogs');
    int _currentValue = (await _databaseReference.get())?.value;
    
    print(_currentValue);
    if (side == CardSwipeOrientation.RIGHT) {
      _databaseReference.set(_currentValue + 1);
    } else if (side == CardSwipeOrientation.LEFT) {
      _databaseReference.set(_currentValue - 1);
    }
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    images.shuffle();

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
            images[index],
            () => controller.triggerRight(),
          ),
          cardController: controller,
          allowVerticalMovement: false,
          totalNum: images.length,
          swipeCompleteCallback: (CardSwipeOrientation side, int _) => likeHandler(side),
        ),
      ),
    );
  }
}