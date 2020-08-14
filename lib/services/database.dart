import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod{

  getUserByUsername(String username) async {
   return await Firestore.instance.collection("users").where("name",isEqualTo: username).getDocuments();

}

  getUserByUseremail(String email) async {
    return await Firestore.instance.collection("users").where("email",isEqualTo: email).getDocuments();

  }
  uploadUserInfo(userMap){
     Firestore.instance.collection("users").add(userMap).catchError((e){

    });
  }
  CreateChatRoom(String chatroomid ,chatroommap){
    Firestore.instance.collection("chatroom").document(chatroomid).setData(chatroommap).catchError((e){});
  }
  
  addConversationMessages(String chatroomid,messagemap){
    Firestore.instance.collection("chatroom").document(chatroomid).collection("chats").add(messagemap).catchError((e){});
  }

  getConversationMessages(String chatroomid)async{
    return await Firestore.instance.collection("chatroom").document(chatroomid).collection("chats").orderBy("time",descending: false).snapshots();
  }

  getChatroom(String username)async{
    return await Firestore.instance.collection("chatroom").where("users",arrayContains: username).snapshots();
  }


}