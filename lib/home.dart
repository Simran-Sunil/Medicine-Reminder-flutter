import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/login.dart';
import 'package:reminder_app/notificationHelper.dart';
import 'package:reminder_app/services/crud.dart';
import 'package:reminder_app/sharedPrefs.dart';
import 'package:reminder_app/widgets/widgets.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();
  Stream usersStream;

  TextEditingController editingController = TextEditingController();

  Widget UsersList() {
    return SingleChildScrollView(
      child: Container(
          child: usersStream != null
              ? Column(children: <Widget>[
                  StreamBuilder(
                      stream: usersStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                return UsersTile(
                                  med_name: snapshot
                                      .data.documents[index].data['med_name'],
                                  dosage: snapshot
                                      .data.documents[index].data['dosage'],
                                  timing: snapshot
                                      .data.documents[index].data['timing'],
                                  deleteitem:
                                      snapshot.data.documents[index].documentID,
                                );
                              });
                        }
                      })
                ])
              : Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )),
    );
  }

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        usersStream = result;
      });
    });
    super.initState();
    //getTime();
  }

  // static periodicCallback() {
  //   NotificationHelper().showNotificationBetweenInterval();
  // }

  String startTime = '';
  String endTime = '';

  // getTime() {
  //   SharedPreferences.getInstance().then((value) {
  //     var a = value.getString('startTime');
  //     var b = value.getString('endTime');
  //     if (a != null && b != null) {
  //       setState(() {
  //         startTime = DateFormat('jm').format(DateTime.parse(a));
  //         endTime = DateFormat('jm').format(DateTime.parse(b));
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: GradientText(
          "       Vaidyanath",
          gradient: LinearGradient(
              colors: [Colors.white, Colors.blue, Colors.blue[800]]),
          style: TextStyle(
              fontSize: 30,
              fontFamily: "GentiumBasic",
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 14)),
            UsersList(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Add  Medicines:",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "GentiumBasic",
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                  FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage()));
                      },
                      child: Icon(Icons.add)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UsersTile extends StatelessWidget {
  String med_name, dosage, timing, deleteitem;
  TextEditingController editingController = TextEditingController();
  CrudMethods crud = new CrudMethods();

  // static periodicCallback() {
  //   NotificationHelper().showNotificationBetweenInterval();
  // }

  String startTime = '';
  String endTime = '';

  UsersTile({
    @required this.med_name,
    @required this.dosage,
    @required this.timing,
    @required this.deleteitem,
  });

  int startIndex = 10;
  int endIndex = 15;
  int starting = 0;
  int ending = 8;

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //future: getReminder(),
    //   builder: (context, snapshot) {
    // var now = DateTime.now();
    // var startTime = DateTime(
    //     now.year,
    //     now.month,
    //     now.day,
    //   //  int.parse(timing.substring(10,12)),
    //   //  int.parse(timing.substring(12, 14))-2);
    //   // eg 7 AM
    //   16,10);
    // var endTime = DateTime(
    //     now.year,
    //     now.month,
    //     now.day,
    //    16,20);// eg 10 PM
    // setStartTime(startTime);
    // setEndTime(endTime);
    // if (snapshot.hasData) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 145,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Card(
        elevation: 10,
        color: Colors.black,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/plus_logo.png',
                    width: 70,
                    height: 70,
                  )),
              Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GradientText(
                      med_name,
                      gradient: LinearGradient(colors: [
                        Colors.blue[800],
                        Colors.blue,
                        Colors.white,
                      ]),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: "GentiumBasic",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 2),
                  Align(
                    alignment: Alignment.center,
                    child: Text("dosage : $dosage",
                        textAlign: TextAlign.center, style: buttonStyle()),
                  ),
                  SizedBox(height: 2),
                  Align(
                    alignment: Alignment.center,
                    child: Text(timing.substring(startIndex, endIndex),
                        textAlign: TextAlign.center, style: buttonStyle()),
                  ),
                  SizedBox(height: 2),
                  Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: Text("Remind me"),
                      textColor: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10)),
                      color: Colors.blue,
                      onPressed: () async {
                        // WidgetsFlutterBinding.ensureInitialized();
                        // await AndroidAlarmManager.initialize();
                        // onTimePeriodic();
                      },
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 40,
                  child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 32,
                      ),
                      color: Colors.grey,
                      onPressed: () {
                        crud.deleteData(deleteitem);
                      }),
                ),
              ),
            ]),
      ),
    );
    // } else {
    //   return CircularProgressIndicator();
    // }
  }
  //  onTimePeriodic() {
  //   SharedPreferences.getInstance().then((value) async {
  //     var a = value.getBool('oneTimePeriodic') ?? false;
  //     if (!a) {
  //       await AndroidAlarmManager.periodic(
  //           Duration(seconds: 30), 0, periodicCallback);
  //       onlyOneTimePeriodic();
  //     } else {
  //       print("Cannot run more than once");
  //     }
  //   });
  // }
}
