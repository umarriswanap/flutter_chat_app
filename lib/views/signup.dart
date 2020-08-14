import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/views/chatroomscreen.dart';
import 'package:flutter_chat_app/widgets/widgets.dart';
import 'package:flutter_chat_app/services/database.dart';



class SignUp extends StatefulWidget {



  final Function toggle;
  SignUp(this.toggle);


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


 

  AuthMethods authMethods=new AuthMethods();
  DatabaseMethod databaseMethod=new DatabaseMethod();

  bool isLoading=false;

  final formkey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController=new TextEditingController();
  TextEditingController emailTextEditingController=new TextEditingController();
  TextEditingController passwordTextEditingController=new TextEditingController();

  SignMeUp(){
    if(formkey.currentState.validate()){
      Map<String,String>userinfoMap={
        "name":usernameTextEditingController.text,
        "email": emailTextEditingController.text
      };
      
     HelperFunction.saveuseremailsharedpreference(emailTextEditingController.text);
     HelperFunction.saveuserusernamesharedpreference(usernameTextEditingController.text);

      setState(() {
        isLoading=true;
      });
      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,passwordTextEditingController.text).then((val){

      });

      databaseMethod.uploadUserInfo(userinfoMap);
      HelperFunction.saveuserloggedinsharedpreference(true);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> ChatRoomScreen()
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(context),
      body:isLoading ? Container(child: Center(child: CircularProgressIndicator()),) : SingleChildScrollView(
        child: Container(

          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: formkey,
                child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val){
                   return val.isEmpty || val.length<5 ? "please provide username with min 5 alphabets":null;
                    },
                    controller:usernameTextEditingController,
                    style: simpletextstyle (),
                    decoration: Inputfield("username"),
                  ),
                  TextFormField(
                    controller:emailTextEditingController,
                    style: simpletextstyle (),
                    decoration: Inputfield("Email"),
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                      null : "Enter correct email";
                    },
                  ),
                  TextFormField(
                    controller:passwordTextEditingController,
                    style: simpletextstyle (),
                    obscureText: true,
                    validator: (val){
                      return  val.length>6 ?null : "please provide password with 6+ charecters";
                    },
                    decoration: Inputfield("Password"),
                  ),
                ],
          ),
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
                  SignMeUp();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors:[Colors.tealAccent,Colors.teal,Colors.tealAccent] ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Sign Up",style: bigtextstyle(),),
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
                child: Text("Sign Up With Google",style: TextStyle(fontSize: 15,color: Colors.black),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account ",style: TextStyle(color:Colors.white,fontSize: 13),),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),

                        child: Text("Sign In now",style: TextStyle(color:Colors.white,fontSize: 13,decoration: TextDecoration.underline),)),
                  ),
                ],
              )


            ],

          ),


        ),
      ),
    );
  }
}
