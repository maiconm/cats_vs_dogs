import 'package:cats_vs_dogs/components/card_widget.dart';
import 'package:cats_vs_dogs/components/counter_widget.dart';
import 'package:cats_vs_dogs/models/pet_interface.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http/http.dart';

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
  Stream<Event> _catsSnaphot = FirebaseDatabase.instance.reference().child('cats').onValue;
  Stream<Event> _dogsSnapshot = FirebaseDatabase.instance.reference().child('dogs').onValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  @override
  void initState() {
    petsInitialState();
    super.initState();
  }

  void petsInitialState() {
    getPets().then(
      (initialPets) {
        setState(() {
          initialPets.forEach((pet) {
            _pets.add(pet);
          });
          _pets.shuffle();
        });
      }
    );
  }

  Future<List> getPets() async {
    PetInterface first = await requestNewPet(true);
    PetInterface second = await requestNewPet(true);
    PetInterface third = await requestNewPet(true);
    PetInterface fourth = await requestNewPet(false);
    PetInterface fifth = await requestNewPet(false);
    PetInterface sixth = await requestNewPet(false);
    return [first, second, third, fourth, fifth, sixth];
  }

  Future<PetInterface> requestNewPet(bool isDog) async {
    Uri url = Uri.parse(isDog ? dogAsApi : ramdomCatApi);
    Response response = await http.get(url);
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return PetInterface(
      jsonResponse[isDog ? 'message' : 'file'],
      isDog ? 'dogs' : 'cats',
    );
  }

  void likeHandler(CardSwipeOrientation side, String type) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child(type);
    int _currentValue = (await databaseReference.get())?.value;

    if (side == CardSwipeOrientation.RIGHT) {
      databaseReference.set(_currentValue + 1);
    }
  }


  Widget getBody() {
    return Column(
      children: [
        Expanded(
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
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                stream: _catsSnaphot,
                builder: (context, AsyncSnapshot<Event>snapshot) {
                  return CounterWidget(
                    snapshot.data?.snapshot.value,
                    Colors.green,
                    'cat'
                  );
                }
              ),
              StreamBuilder(
                stream: _dogsSnapshot,
                builder: (context, AsyncSnapshot<Event> snapshot) {
                  return CounterWidget(
                    snapshot.data?.snapshot.value,
                    Colors.blue,
                    'dog'
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}