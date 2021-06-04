import 'package:cats_vs_dogs/components/card_widget.dart';
import 'package:cats_vs_dogs/models/pet_interface.dart';
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
  CardController _controller = CardController();
  List<PetInterface> _pets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  @override
  void initState() {
    getInitialPets().then(
      (initialImages) {
        setState(() {
          initialImages.forEach((image) {
            _pets.add(image);
          });
        });
      }
    );
    super.initState();
  }

  Future<List> getInitialPets() async {
    var first = await requestNewPet(true);
    var second = await requestNewPet(true);
    var third = await requestNewPet(true);
    var fourth = await requestNewPet(false);
    var fifth = await requestNewPet(false);
    var sixth = await requestNewPet(false);
    return [first, second, third, fourth, fifth, sixth];
  }

  Future<PetInterface> requestNewPet(bool isDog) async {
    var url = Uri.parse(isDog ? dogAsApi : ramdomCatApi);
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return PetInterface(
      jsonResponse[isDog ? 'message' : 'file'],
      isDog ? 'dogs' : 'cats',
    );
  }

  void likeHandler(CardSwipeOrientation side, String type) async {
    DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child(type);
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
    _pets.shuffle();

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
            _pets[index].imageUrl,
            () => _controller.triggerRight(),
          ),
          cardController: _controller,
          allowVerticalMovement: false,
          totalNum: _pets.length,
          swipeCompleteCallback: (CardSwipeOrientation side, int index) => likeHandler(side, _pets[index].type),
        ),
      ),
    );
  }
}