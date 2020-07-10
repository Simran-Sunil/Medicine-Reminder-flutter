import 'package:flutter/material.dart';


TextStyle aboutPageStyle() {
  return TextStyle(
      color: Colors.grey[500], fontSize: 20, fontFamily: "GentiumBasic");
}

TextStyle textStyle() {
  return TextStyle(
      color: Colors.blue, fontSize: 20, fontFamily: "GentiumBasic");
}

TextStyle pageStyle() {
  return TextStyle(
      color: Colors.black, fontSize: 20, fontFamily: "GentiumBasic");
}

TextStyle buttonStyle() {
  return TextStyle(
      color: Colors.white, fontSize: 18, fontFamily: "GentiumBasic");
}

OutlineInputBorder borderStyle() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.blue),
  );
}

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      'assets/logo.png',
      height: 80,
      width: 90,
    ),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ));
}

TextStyle mediumTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
