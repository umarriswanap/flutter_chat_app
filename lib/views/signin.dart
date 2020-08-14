import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/services/database.dart';
import 'package:flutter_chat_app/views/chatroomscreen.dart';
import 'package:flutter_chat_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  QuerySnapshot snapshotuserinfo;
  AuthMethods authMethods=new AuthMethods();
  DatabaseMethod databaseMethod=new DatabaseMethod();

  TextEditingController passwordTextEditingController=new TextEditingController();
  TextEditingController emailTextEditingController=new TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isLoading=false;
  SignIn(){
  if(formkey.currentState.validate()){

 HelperFunction.saveuseremailsharedpreference(emailTextEditingController.text);

    setState(() {
      isLoading=true;
    });
    databaseMethod.getUserByUseremail(emailTextEditingController.text).then((val){
   snapshotuserinfo=val;
   HelperFunction.saveuserusernamesharedpreference(snapshotuserinfo.documents[0].data["name"]);
    });
    authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((e){
  if(e!=null){

    HelperFunction.saveuserloggedinsharedpreference(true);
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> ChatRoomScreen()));
  }
    });

  }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBarMain(context),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formkey,
                  child: Column(children: <Widget>[
              TextFormField(
                validator: (val){
                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                  null : "Enter correct email";
                },
              controller: emailTextEditingController,
              style: simpletextstyle (),
              decoration: Inputfield("Email"),
            ),
            TextFormField(
              validator: (val){
                return  val.length>6 ?null : "please provide password with 6+ charecters";
              },
              controller: passwordTextEditingController,
              style: simpletextstyle (),
              obscureText: true,
              decoration: Inputfield("Password"),
            ),
              ],),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Text("Forgot password?",
                    style: simpletextstyle(),),
                  ),
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    SignIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors:[Colors.tealAccent,Colors.teal,Colors.tealAccent] ),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Sign In",style: bigtextstyle(),),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Sign In With Google",style: TextStyle(fontSize: 15,color: Colors.black),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Dont have an account? ",style: TextStyle(color:Colors.white,fontSize: 13),),
                    GestureDetector(
                      onTap: (){widget.toggle();},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Register now",style: TextStyle(color:Colors.white,fontSize: 13,decoration: TextDecoration.underline),)),
                    ),
                  ],
                )


              ],

            ),


          ),
        ),
      ),
    );
  }
}
