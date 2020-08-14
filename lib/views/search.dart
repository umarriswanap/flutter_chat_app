import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/constants.dart';
import 'package:flutter_chat_app/services/database.dart';
import 'package:flutter_chat_app/views/conversationscreen.dart';
import 'package:flutter_chat_app/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {




  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  initiateSearch(){
    databaseMethod.getUserByUsername(searchTexteditingController.text).then((val){
      setState(() {
        SearchSnapShot=val;
      });
    });
  }

  DatabaseMethod databaseMethod=new DatabaseMethod();

  QuerySnapshot SearchSnapShot;

  TextEditingController searchTexteditingController=new TextEditingController();

  Widget Searchlist(){

    return SearchSnapShot!=null ? ListView.builder(
        itemCount: SearchSnapShot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return SearchTile(
            useremail: SearchSnapShot.documents[index].data["email"],
            username: SearchSnapShot.documents[index].data["name"],
          );


        }


    ):Container();
  }
  CreateChatROOMAndStartConversation({String username}){

    if(username!=Constants.myname){
      String chatroomid=getChatRoomId(username,Constants.myname);

      List<String>users=[username,Constants.myname];
      Map<String,dynamic>chatroommap={
        "users":users,
        "chatroomid":chatroomid
      };
      DatabaseMethod().CreateChatRoom(chatroomid, chatroommap);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen(chatroomid)));
    }

  }

  Widget SearchTile({String username, String useremail}){
    return Container(
      color:Colors.black12,
      padding: EdgeInsets.symmetric(vertical: 24,horizontal: 20 ),
      child: Row(

        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(username,style:simpletextstyle()),
              Text(useremail,style: simpletextstyle(),)
            ],),
          Spacer(),
          GestureDetector(
            onTap: (){
              CreateChatROOMAndStartConversation(username: username);
            },
            child: Container(

              decoration: BoxDecoration(
                  gradient: LinearGradient(colors:[Colors.tealAccent,Colors.teal,Colors.tealAccent] ),
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("Message"),
            ),
          )

        ],
      ),
    );
  }

  @override
  void initState() {

    initiateSearch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(context),
      body: Container(
        child: Column(

          children: <Widget>[
            Container(
              color: Colors.white10,
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
              child: Row(

                children: <Widget>[
                  Expanded(

                      child: TextField(
                        controller: searchTexteditingController,
                        style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search username..",
                        hintStyle: TextStyle(
                          color: Colors.white30,
                        ),
                        border: InputBorder.none,
                      ),


                      )),
                  GestureDetector(
                    onTap: (){
                    initiateSearch();
                      },
                      child: Container(
                      height: 35,
                    width: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors:[Colors.tealAccent,Colors.teal,Colors.tealAccent] ),
                          borderRadius: BorderRadius.circular(35)
                        ),

                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
            Searchlist(),
          ],
        ),

      ),

    );
  }
}



getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

