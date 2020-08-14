import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/authenticate.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/views/chatroomscreen.dart';
import 'package:flutter_chat_app/views/signup.dart';
import './views/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userloggedin=false;
  @override
  void initState() {
    getLoggedInState();
    // TODO: implement initState
    super.initState();
  }
  getLoggedInState()async{
   await HelperFunction.getuserloggedinsharedpreference().then((val){
     setState(() {
       userloggedin=val;
     });
   });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black54,
        primarySwatch: Colors.blue,
      ),
      home: userloggedin!=null ? ChatRoomScreen() : Authenticate() );

  }
}



