import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:random_string/random_string.dart';
//import 'package:reminder_app/notificationHelper.dart';
import 'package:reminder_app/services/crud.dart';
import 'package:reminder_app/sharedPrefs.dart';
import 'package:reminder_app/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    setState(() {
      _time = picked;
      print(_time);
    });
  }

  Item selectedUser;
  bool _isLoading = false;
  String med_name, med_type, dosage, timing;
  CrudMethods crudMethods = new CrudMethods();

  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  List<Item> users = <Item>[
    const Item(
      'Syrup',
      Icon(MdiIcons.bottleTonicPlus, color: Colors.blue),
    ),
    const Item(
      'Tablets',
      Icon(MdiIcons.circle, color: Colors.blue),
    ),
    const Item(
      'Capsules',
      Icon(MdiIcons.pill, color: Colors.blue),
    ),
    const Item(
      'Inhalers',
      Icon(MdiIcons.lungs, color: Colors.blue),
    ),
    const Item(
      'Ointment',
      Icon(MdiIcons.toothbrushPaste, color: Colors.blue),
    ),
    const Item(
      'Syringe',
      Icon(MdiIcons.needle, color: Colors.blue),
    ),
    const Item(
      'Drops',
      Icon(MdiIcons.eyedropper, color: Colors.blue),
    ),
  ];

  uploadData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
  
    Map<String, String> regMap = {
      "med_name": med_name,
      "med_type": selectedUser.name,
      "dosage": dosage,
      "timing": _time.toString(),
      "uid": uid,
    };

    crudMethods.addData(regMap).then((result) {
      Navigator.pop(context);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
            GradientText("Medicine  Details",
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue, Colors.blue[800]]),
                style: TextStyle(fontSize: 27, fontFamily: "GentiumBasic")),
          ],
        ),
      ),
      body: _isLoading
          ? SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                 
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.all(9),
                    child: TextFormField(
                        onChanged: (val) {
                          med_name = val;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Medicine Name",
                          hintStyle: aboutPageStyle(),
                          fillColor: Colors.white,
                          enabledBorder: borderStyle(),
                          focusedBorder: borderStyle(),
                        )),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.all(9),
                    child: TextFormField(
                        onChanged: (val) {
                          dosage = val;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Dosage in mg",
                          hintStyle: aboutPageStyle(),
                          fillColor: Colors.white,
                          enabledBorder: borderStyle(),
                          focusedBorder: borderStyle(),
                        )),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      width: 360,
                      height: 60,
                      decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue, width: 1)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Select Category",
                                  style: aboutPageStyle(),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                child: DropdownButton<Item>(
                                  focusColor: Colors.grey,
                                  hint: Text(
                                    "Select Item",
                                  ),
                                  value: selectedUser,
                                  onChanged: (Item Value) {
                                    setState(() {
                                      selectedUser = Value;
                                    });
                                  },
                                  items: users.map((Item user) {
                                    return DropdownMenuItem<Item>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          user.icon,
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            user.name,
                                            style: TextStyle(
                                                color: Colors.blue[700]),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                    vertical: 20,
                  )),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                      Text(
                        "Set Time:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: "GentiumBasic",
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                      RaisedButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5)),
                            Text(
                              "Edit Time",
                              style: pageStyle(),
                            ),
                          ],
                        ),
                        onPressed: () {
                          selectTime(context);
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(19)),
                      ),
                    ],
                  ),

                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  RaisedButton(
                    color: Colors.blue,
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Add Medicine",
                      style: pageStyle(),
                    ),
                    onPressed: () async {
                      uploadData();
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20)),
                  ),
                ],
              ),
            ),
    );
  }
}
