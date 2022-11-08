import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'Coffee.dart';
import 'Details.dart';
import 'Orders.dart';
import 'Profile.dart';
import 'icons.dart';

class loaddataFavorites extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String uid() {
    final User user = auth.currentUser;
    final userid = user.uid;
    String u_id = userid;
    return 'Your UID : $u_id';
  }

  @override
  Widget build(BuildContext context) {
    List<String> productname_favorites = <String>[];
    List<String> productdescription_favorites = <String>[];
    List<String> productprice_favorites = <String>[];

    CollectionReference collectiontogetFavorites = FirebaseFirestore.instance
        .collection('users')
        .doc(uid())
        .collection('favorites');

    Future<void> getDatafromFavorites() async {
      QuerySnapshot querySnapshot = await collectiontogetFavorites.get();

      final allData =
          querySnapshot.docs.map((doc) => doc.data()).toList().toString();
      String workingstring = allData
          .substring(1, allData.length - 1)
          .replaceAll(":", "")
          .replaceAll("{", "")
          .replaceAll("}", "");

      for (String a in workingstring.split(", ")) {
        if (a != "") {
          String work = a.substring(7, a.length);
          if (work.substring(0, 1) == "n") {
            String data = work.substring(5, work.length);
            productname_favorites.add(data);
          }
          if (work.substring(0, 1) == "d") {
            String data = work.substring(12, work.length);
            productdescription_favorites.add(data);
          }
          if (work.substring(0, 1) == "p") {
            String data = work.substring(6, work.length);
            productprice_favorites.add(data);
          }
        }
      }
      Future.delayed(
          const Duration(seconds: 0),
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Favoriting(productname_favorites,
                      productdescription_favorites, productprice_favorites)),
              (route) => false));
    }

    getDatafromFavorites();

    return Container(width: 0, height: 0);
  }
}

class Favoriting extends StatefulWidget {
  final List<String> productname_favorites;
  final List<String> productdescription_favorites;
  final List<String> productprice_favorites;
  Favoriting(this.productname_favorites, this.productdescription_favorites,
      this.productprice_favorites);

  FavoritingState createState() => FavoritingState(productname_favorites,
      productdescription_favorites, productprice_favorites);
}

class FavoritingState extends State<Favoriting> {
  final List<String> productname_favorites;
  final List<String> productdescription_favorites;
  final List<String> productprice_favorites;

  FavoritingState(this.productname_favorites, this.productdescription_favorites,
      this.productprice_favorites);

  final FirebaseAuth auth = FirebaseAuth.instance;

  String text() {
    final User user = auth.currentUser;
    final uid = user.displayName;
    String string = uid;
    return 'Your favorites , $string ';
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: width / 20, top: height / 20),
              child: SizedBox(
                height: 48,
                child: Text(text(),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.comicNeue(
                        textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
              )),
          Padding(
              padding:
                  EdgeInsets.only(left: width / 20, right: width / 20, top: 20),
              child: Container(
                  height: height / 1.6 + 100,
                  child: Favorite(productname_favorites,
                      productdescription_favorites, productprice_favorites))),
          Padding(
              padding:
                  EdgeInsets.only(left: width / 20, top: 20, right: width / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => getData()),
                              (route) => false);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(MyFlutterApp.home, size: 24),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text("Home",
                                    style: GoogleFonts.comicNeue(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))))
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: width / 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => getinfo()),
                              (route) => false);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(MyFlutterApp.coffeecup, size: 24),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text("Orders",
                                    style: GoogleFonts.comicNeue(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))))
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: width / 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(MyFlutterApp.clickedheart, size: 24),
                          Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("Favorites",
                                  style: GoogleFonts.comicNeue(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))))
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: width / 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                              (route) => false);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(MyFlutterApp.user, size: 24),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text("Profile",
                                    style: GoogleFonts.comicNeue(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))))
                          ],
                        ),
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

class Favorite extends StatefulWidget {
  final List<String> productname;
  final List<String> productdescription;
  final List<String> productprice;
  const Favorite(this.productname, this.productdescription, this.productprice);
  FavoriteState createState() =>
      FavoriteState(productname, productdescription, productprice);
}

class FavoriteState extends State<Favorite> {
  final List<String> productname;
  final List<String> productdescription;
  final List<String> productprice;
  FavoriteState(this.productname, this.productdescription, this.productprice);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        itemCount: productname.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int idx) {
          return _coffeeListCard(
              "assets/images/coffee.png",
              productname[idx],
              "CoffeeShop",
              productdescription[idx],
              productprice[idx],
              true,
              width,
              height);
        });
  }

  _coffeeListCard(
      String imgPath,
      String coffeeName,
      String shopName,
      String description,
      String price,
      bool isFavorite,
      double width,
      double height) {
    return Padding(
        padding: EdgeInsets.only(left: width / 20, right: width / 20),
        child: Container(
            height: 0.6 * height,
            width: 0.8 * width,
            child: Column(
              children: <Widget>[
                Stack(children: [
                  Container(height: 0.5 * height),
                  Positioned(
                      top: 0.1 * height,
                      child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          height: 0.4 * height,
                          width: 0.8 * width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Colors.pink[100]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 0.075 * height,
                                ),
                                SizedBox(
                                    height: 20,
                                    child: Text(
                                      shopName + '\'s',
                                      style: GoogleFonts.comicNeue(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    )),
                                SizedBox(height: 10),
                                SizedBox(
                                    height: 32,
                                    child: Text(coffeeName,
                                        style: GoogleFonts.comicNeue(
                                            textStyle: const TextStyle(
                                                fontSize: 28,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)))),
                                SizedBox(height: 5),
                                SizedBox(
                                  height: height * 0.175,
                                  child: Text(description,
                                      style: GoogleFonts.comicNeue(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(price,
                                            style: GoogleFonts.comicNeue(
                                                textStyle: const TextStyle(
                                                    fontSize: 25,
                                                    color: Color(0xFF3A4742),
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Heart(isFavorite, coffeeName,
                                            description, price)
                                      ],
                                    ))
                              ]))),
                  Positioned(
                      left: 0.3 * width,
                      child: Container(
                          height: 0.15 * height,
                          width: 0.2 * width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.fitHeight))))
                ]),
                BuyFavorite(coffeeName, description, price)
              ],
            )));
  }
}

class BuyFavorite extends StatelessWidget {
  final String coffeename;
  final String coffeedescription;
  final String coffeeprice;

  BuyFavorite(this.coffeename, this.coffeedescription, this.coffeeprice);

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(
                      coffeename, coffeedescription, coffeeprice, true)));
            },
            child: Container(
                height: height / 20,
                width: 0.8 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xFF473D3A)),
                child: Center(
                    child: Text('Order Now',
                        style: GoogleFonts.comicNeue(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))))));
  }
}
