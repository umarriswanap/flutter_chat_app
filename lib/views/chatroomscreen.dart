import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/authenticate.dart';
import 'package:flutter_chat_app/helper/constants.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/services/database.dart';
import 'package:flutter_chat_app/views/conversationscreen.dart';
import 'package:flutter_chat_app/views/search.dart';
import 'package:flutter_chat_app/views/signin.dart';
import 'package:flutter_chat_app/widgets/widgets.dart';
class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();


}
String Myname;
class _ChatRoomScreenState extends State<ChatRoomScreen> {
  Stream chatroomstreem;

  AuthMethods authMethods=new AuthMethods();
  DatabaseMethod dataBaseMethods=new DatabaseMethod();

  Widget chatroomlist(){
    return StreamBuilder(
      stream: chatroomstreem,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index) {
              return chatrromtile(
                  snapshot.data.documents[index].data["chatroomid"]
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll(Constants.myname, ""),
                  snapshot.data.documents[index].data["chatroomid"]);
            }):Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();

    // TODO: implement initState
    super.initState();
  }
getUserInfo()async{
    Constants.myname=await HelperFunction.getuserusernamesharedpreference();
    dataBaseMethods.getChatroom(Constants.myname).then((val){
      setState(() {
        chatroomstreem=val;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text("My Chat App"),
        backgroundColor: Colors.teal,
       actions: [
         GestureDetector(
           onTap: (){
             authMethods.SignOut();
             Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context)=>Authenticate()
             )

             );
           },
           child: Container(
             padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
               child: Icon(Icons.exit_to_app)),
         )
       ]
       ,
      ),
      body: chatroomlist(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,

          child: Icon(
              Icons.search,
            color: Colors.white,
          ),
          onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
      }),
    );
  }
}
class chatrromtile extends StatelessWidget {
  String username;
  String chatroomid;
  chatrromtile(this.username,this.chatroomid);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen(chatroomid)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
        child: Row(
          children: <Widget>[Container(
            height: 40,
            width: 40,
           alignment: Alignment.center,
           decoration: BoxDecoration(
             gradient: LinearGradient(colors:[Colors.tealAccent,Colors.teal,Colors.tealAccent]),
             borderRadius: BorderRadius.circular(40)
           ),
            child: Text("${username.substring(0,1).toUpperCase()}"),
          ),
          SizedBox(width: 8,),
          Text(username,style: bigtextstyle (),)],
        ),
      ),
    );
  }
}

