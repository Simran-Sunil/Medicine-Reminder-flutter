import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:reminder_app/login.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
        child:Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical:70)),
            Image.asset(
            'assets/plus_logo.png',
            width: 200,
            height: 200,
          ),Padding(padding:EdgeInsets.symmetric(vertical:15)),
         GradientText("Vaidyanath",
          gradient: LinearGradient(
    colors: [Colors.white, Colors.blue, Colors.blue[800]]),
         style: TextStyle(color:Colors.white, 
          fontFamily: "GentiumBasic",fontSize: 44,fontWeight: FontWeight.w500),
          ),
          ],
        ),
         
        ));
  }
}