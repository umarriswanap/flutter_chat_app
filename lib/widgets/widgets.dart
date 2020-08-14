import 'package:flutter/material.dart';

Widget AppBarMain(BuildContext context){
  return AppBar(
      title: Text("My Chat App"),
      backgroundColor: Colors.teal,
  ); 
}

InputDecoration Inputfield(String name){
  return InputDecoration(
        hintText: name,
        hintStyle: TextStyle(
          color: Colors.white30,
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
        ),
      enabledBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.white30)
    ),

  );
}
TextStyle simpletextstyle (){
  return TextStyle(
      color: Colors.white,
    fontSize: 13,


  );
}
TextStyle bigtextstyle (){
  return TextStyle(
    color: Colors.white,
    fontSize: 15,


  );
}