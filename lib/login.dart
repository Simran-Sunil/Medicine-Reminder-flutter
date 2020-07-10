import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:reminder_app/helper/helperfunctions.dart';
import 'package:reminder_app/home.dart';
import 'package:reminder_app/services/auth.dart';
import 'package:reminder_app/services/crud.dart';
import 'package:reminder_app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  CrudMethods databaseMethods= new CrudMethods();
  
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String>userInfoMap= {
          "name" : userNameTextEditingController.text,
          "email":emailTextEditingController.text,
        };
    HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
    HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);


      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        // print("${val.uId}");
        
        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical:25),
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(mainAxisSize: MainAxisSize.min, 
                  children: [
                    Image.asset('assets/plus_logo.png',
                    width: 150,
            height: 150,),
            Padding(padding:  EdgeInsets.symmetric(vertical:10),),
            
           GradientText("Vaidyanath",
          gradient: LinearGradient(
    colors: [Colors.white, Colors.blue, Colors.blue[800]]),
         style: TextStyle(color:Colors.white, 
          fontFamily: "GentiumBasic",fontSize: 25,fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 27,),
           Padding(padding: EdgeInsets.symmetric(vertical:10),),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty || val.length < 2
                                  ? "Please provide a valid username"
                                  : null;
                            },
                            controller: userNameTextEditingController,
                            style:aboutPageStyle(),
                            decoration: textFieldInputDecoration("Username"),
                          ),
                          SizedBox(
                      height: 8.0,
                    ),
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Enter correct email";
                            },
                            controller: emailTextEditingController,
                            style:aboutPageStyle(),
                            decoration: textFieldInputDecoration("Email"),
                          ),
                          SizedBox(
                      height: 8.0,
                    ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "Enter Password 6+ characters";
                            },
                            controller: passwordTextEditingController,
                            style: aboutPageStyle(),
                            decoration: textFieldInputDecoration(
                              "Password",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        //todo
                        signMeUp();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue[900], Colors.lightBlue]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Sign Up",
                          style:pageStyle(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(height: 15)
                  ]),
                ),
              ),
            ),
    );
  }
}
