import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'View/splashScreen.dart';
import 'View/loginPage.dart';
import 'View/homePage.dart';
import 'View/addPage.dart';
import 'constants.dart';

void main(){
    Random rand = Random(DateTime.now().millisecond);
    
    int randIndex = rand.nextInt(themeColor.length);
    control = themeColor[randIndex];
    
    //WidgetsFlutterBinding.ensureInitialized();
    runApp(MyMainApp());
}
/*
class App extends StatelessWidget{
  final Future<FirebaseApp> _initial;
    @override 
    Widget build(BuildContext con){
        return FutureBuilder(
          future:_initial,
          builder: (con, snapshot){
            if(snapshot.hasError){
              return Text("app failed");
            }

            if(snapshot.connectionState == ConnectionState.done){
              return MyMainApp();
            }

            return CircularProgressIndicator();
          }
        );
    }
}
*/

class MyMainApp extends StatelessWidget{
    @override 
    Widget build(BuildContext con){
        return MaterialApp(
            debugShowCheckedModeBanner:false,
            initialRoute:'/',
            routes:{
                '/':(con) => SplashScreen(),
                '/login':(con) => LoginPage(),
                '/home':(con) => HomePage(),
                '/add' :(con) => AddPage(),
            }
        );
    }
}

