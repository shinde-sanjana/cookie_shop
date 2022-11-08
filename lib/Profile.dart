import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'Coffee.dart';
import 'Details.dart';
import 'Favorites.dart';
import 'Orders.dart';
import 'icons.dart';
import 'main.dart'; 

class Profile extends StatelessWidget {
  
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }


  final FirebaseAuth auth = FirebaseAuth.instance;

  String text() {
    final User user = auth.currentUser;
    final uid = user.displayName;
    String string = uid;
    return 'Welcome , $string ';
  }

  String uid() {
    final User user = auth.currentUser;
    final userid = user.uid;
    String u_id = userid;
    return 'Your UID : $u_id';
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
              padding: EdgeInsets.only(left: width / 20, top: 10),
              child: SizedBox(
                height: 44,
                child: Text(uid(),
                    style: GoogleFonts.comicNeue(
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.grey))),
              )),
          Padding(
              padding:
                  EdgeInsets.only(top: 20, left: width / 20, right: width / 20),
              child: SizedBox(
                width: width,
                child: TextButton(
                  onPressed: () {
                    signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                        (route) => false);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)))),
                  child: Text("SIGN OUT",
                      style: GoogleFonts.comicNeue(
                          textStyle: const TextStyle(
                              fontSize: 24, color: Colors.white))),
                ),
              )),
          Padding(
              padding:
                  EdgeInsets.only(left: width / 20, right: width / 20, top: 20),
              child: SizedBox(
                height: height / 1.6 - 20,
              )),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loaddataFavorites()),
                              (route) => false);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(MyFlutterApp.heart, size: 24),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text("Favorites",
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
                          Icon(MyFlutterApp.clickedaccount, size: 24),
                          Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("Profile",
                                  style: GoogleFonts.comicNeue(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))))
                        ],
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
