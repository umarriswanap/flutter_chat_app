import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/constants.dart';
import 'package:flutter_chat_app/services/database.dart';
import 'package:flutter_chat_app/widgets/widgets.dart';

class ConversationScreen extends StatefulWidget {

  final String chatroomid;
  ConversationScreen(this.chatroomid);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethod databaseMethod=new DatabaseMethod();
  TextEditingController messagecontroller=new TextEditingController();
  Stream chatMESSAGEStream;

  Widget ChatMessageList(){
    return  StreamBuilder(
      stream: chatMESSAGEStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
            return MessageTile(snapshot.data.documents[index].data["message"],
            snapshot.data.documents[index].data["sendby"]==Constants.myname);
            }):Container();
      },
    );


  }

  Sendmessage(){
    if(messagecontroller.text.isNotEmpty){
      Map<String,dynamic> messagemap = {
        "message":messagecontroller.text,
        "sendby":Constants.myname,
        "time":DateTime.now().millisecondsSinceEpoch
    };

      databaseMethod.addConversationMessages(widget.chatroomid,messagemap);
      messagecontroller.text="";
    };



  }
  
  @override
  void initState() {
    databaseMethod.getConversationMessages(widget.chatroomid).then((val){
      setState(() {
        chatMESSAGEStream=val;
      });
    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(context),
      body: Container(
        child: Stack(
          children: <Widget>[
            ChatMessageList(),
            Container(
                alignment: Alignment.bottomCenter,
                    color: Colors.black12,
                    padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                    child: Row(


                      children: <Widget>[
                        Expanded(


                            child: Container(

                              child: TextField(

                                controller: messagecontroller,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Message..",
                                  hintStyle: TextStyle(
                                    color: Colors.white30,
                                  ),

                                  border: InputBorder.none,
                                ),

                              ),
                            )),
                        GestureDetector(
                          onTap: (){
                            Sendmessage();
                          },
                          child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors:[Colors.tealAccent,Colors.teal,Colors.tealAccent] ),
                                  borderRadius: BorderRadius.circular(35)
                              ),

                              padding: EdgeInsets.all(10),
                              child: Image.asset("assets/images/send.png")),
                        )
                      ],
                    ),





    )
          ],
    ),
        ),

    );
  }
}
class MessageTile extends StatelessWidget {
  final String Message;
  final bool issendbyme;
  MessageTile(this.Message,this.issendbyme);
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 6),
   margin: EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      alignment: issendbyme ? Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: issendbyme ? [Colors.teal,Colors.tealAccent]:[Colors.white70,Colors.white12]),
                borderRadius: issendbyme?BorderRadius.only(topLeft: Radius.circular(20),bottomLeft:Radius.circular(20),topRight:Radius.circular(20)  ):BorderRadius.only(bottomRight: Radius.circular(23),bottomLeft:Radius.circular(23),topRight:Radius.circular(23))
        ),
          child: Text(Message,style:TextStyle(
          color:issendbyme?Colors.black: Colors.white,
          fontSize: 16,


        ) ,),
      ),
    );
  }
}
