import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../constants.dart';

class SplashScreen extends StatelessWidget {
  BuildContext cont;

  

  @override
  Widget build(BuildContext con) {
    cont = con;
    loadLoginPage();
    return Scaffold(
      body: _page(),
    );
  }

    void loadLoginPage(){
        Future.delayed(
            Duration(seconds:5),
            (){
                Navigator.pushReplacementNamed(cont,'/home');
            }
        );
    }
  Widget _page() {
    return Container(
      child: Stack(children: <Widget>[
        Positioned(
            child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  color: control,
                ))),
        Positioned(
          top: MediaQuery.of(cont).size.height /3, 
          left: MediaQuery.of(cont).size.width / 3,
          child:Image.asset('assets/images/recycleWhite.png',height:100,width:100)
        ),
        Positioned(
            top: MediaQuery.of(cont).size.height/3+100, 
            left: MediaQuery.of(cont).size.width / 4, 
            child: Text("Leecit", 
            style: TextStyle(color: base, fontWeight: FontWeight.bold, fontSize: 70))),
      ]),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - size.height/6);
    path.quadraticBezierTo(100, size.height - size.height/18, size.width/3, size.height - size.height/6);
    path.quadraticBezierTo(size.width -200, size.height/2, size.width, size.height-size.height/2);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
