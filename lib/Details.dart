import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:fluttercookie/Coffee.dart';

import 'Orders.dart';

class DetailsPage extends StatefulWidget {
  final String coffeename;
  final String coffeedescription;
  final String coffeeprice;
  final bool coffeefavorited;

  DetailsPage(this.coffeename, this.coffeedescription, this.coffeeprice,
      this.coffeefavorited);

  @override
  _DetailsPageState createState() => _DetailsPageState(
      coffeename, coffeedescription, coffeeprice, coffeefavorited);
}

class _DetailsPageState extends State<DetailsPage> {
  final String coffeename;
  final String coffeedescription;
  final String coffeeprice;
  final bool coffeefavorited;

  _DetailsPageState(this.coffeename, this.coffeedescription, this.coffeeprice,
      this.coffeefavorited);

  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid() {
    final User user = auth.currentUser;
    final userid = user.uid;
    String u_id = userid;
    return 'Your UID : $u_id';
  }

  @override
  Widget build(BuildContext context) {
    var instance;
    CollectionReference collectiontogetOrders = FirebaseFirestore.instance
        .collection('users')
        .doc(uid())
        .collection('orders');

    return Scaffold(
        body: ListView(physics: const BouncingScrollPhysics(), children: [
      Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 20.0,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFF3B2B7)),
          Positioned(
              top: MediaQuery.of(context).size.height / 2.5,
              child: Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0)),
                      color: Colors.white))),
          Positioned(
              top: MediaQuery.of(context).size.height / 2.5 + 25,
              left: 15.0,
              child: Container(
                  height: (MediaQuery.of(context).size.height / 1.6),
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Text('Preparation time',
                            style: GoogleFonts.comicNeue(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                        SizedBox(height: 7.0),
                        Text(
                          '5 min',
                          style: GoogleFonts.comicNeue(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: Container(
                            height: 0.5,
                            color: Color(0xFFC6C4C4),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Ingredients',
                          style: GoogleFonts.comicNeue(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF726B68))),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                            height: 110.0,
                            child: ListView(
                                padding: EdgeInsets.all(0),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: false,
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  buildIngredientItem(
                                      'Water',
                                      Icon(Icons.accessibility_new,
                                          size: 10.0, color: Colors.white),
                                      Color(0xFF6FC5DA)),
                                  buildIngredientItem(
                                      'Brewed Espresso',
                                      Icon(Icons.accessibility_new,
                                          size: 18.0, color: Colors.white),
                                      Color(0xFF615955)),
                                  buildIngredientItem(
                                      'Sugar',
                                      Icon(Icons.accessibility_new,
                                          size: 18.0, color: Colors.white),
                                      Color(0xFFF39595)),
                                  buildIngredientItem(
                                      'Toffee Nut Syrup',
                                      Icon(Icons.accessibility_new,
                                          size: 18.0, color: Colors.white),
                                      Color(0xFF8FC28A)),
                                  buildIngredientItem(
                                      'Natural Flavors',
                                      Icon(Icons.accessibility_new,
                                          size: 18.0, color: Colors.white),
                                      Color(0xFF3B8079)),
                                  buildIngredientItem(
                                      'Vanilla Syrup',
                                      Icon(Icons.accessibility_new,
                                          size: 18.0, color: Colors.white),
                                      Color(0xFFF8B870)),
                                  SizedBox(width: 25.0)
                                ])),
                        Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: Container(
                            height: 0.5,
                            color: Color(0xFFC6C4C4),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Nutrition Information',
                          style: GoogleFonts.comicNeue(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(height: 10.0),
                        Row(children: [
                          Text(
                            'Calories :',
                            style: GoogleFonts.comicNeue(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            '250',
                            style: GoogleFonts.comicNeue(
                                textStyle: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF716966))),
                          ),
                        ]),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Text(
                              'Proteins :',
                              style: GoogleFonts.comicNeue(
                                  textStyle: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              '10g',
                              style: GoogleFonts.comicNeue(
                                  textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF716966))),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Text(
                              'Caffeine :',
                              style: GoogleFonts.comicNeue(
                                  textStyle: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              '150mg',
                              style: GoogleFonts.comicNeue(
                                  textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF716966))),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: Container(
                            height: 0.5,
                            color: Color(0xFFC6C4C4),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
                            collectiontogetOrders.add({
                              'productname': coffeename,
                              'productdescription': coffeedescription,
                              'productprice': coffeeprice,
                              'productfavorited': coffeefavorited
                            });
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => getinfo()),
                                (route) => false);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(right: 25.0),
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35.0),
                                    color: Color(0xFF473D3A)),
                                child: Center(
                                  child: Text(
                                    'Make Order',
                                    style: GoogleFonts.comicNeue(
                                        textStyle: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(height: 5.0)
                      ]))),
          Positioned(
              top: 25.0,
              left: 15.0,
              right: 20.0,
              child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Back',
                                style: GoogleFonts.comicNeue(
                                    textStyle: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF726B68)))),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(coffeename,
                                  style: GoogleFonts.comicNeue(
                                      textStyle: const TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                            ),
                            SizedBox(width: 15.0),
                            Heart(coffeefavorited, coffeename,
                                coffeedescription, coffeeprice)
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(coffeedescription,
                              style: GoogleFonts.comicNeue(
                                  textStyle: const TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        )
                      ])))
        ],
      )
    ]));
  }

  buildIngredientItem(String name, Icon iconName, Color bgColor) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Column(children: [
          Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0), color: bgColor),
              child: Center(child: iconName)),
          SizedBox(height: 4.0),
          Container(
              width: 60.0,
              child: Center(
                  child: Text(name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comicNeue(
                          textStyle: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)))))
        ]));
  }
}

class FirebaseFirestore {
  static var instance;
}

class User {
  var uid;

  get displayName => null;

  bool get emailVerified => null;

  void sendEmailVerification() {}
}

class GoogleFonts {
  static comicNeue({TextStyle textStyle, Color color}) {}
}

class CollectionReference {
  void add(Map<String, Object> map) {}

  where(String s, {String isEqualTo}) {}

  get() {}
}

class FirebaseAuth {
  static FirebaseAuth instance;

  User get currentUser => null;

  createUserWithEmailAndPassword({String email, String password}) {}

  userChanges() {}

  signInWithEmailAndPassword({String email, String password}) {}

  signOut() {}
}
