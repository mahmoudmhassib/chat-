import 'package:chatfirebase/widget/messageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MessageText extends StatefulWidget {
  const MessageText({super.key});

  @override
  State<MessageText> createState() => _MessageTextState();
}

class _MessageTextState extends State<MessageText> {

  void getData() async {
    print(await FirebaseFirestore.instance.collection('/chat').orderBy('messageTime',descending: true).snapshots());
  }

  @override
  void initState()  {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection('/chat').orderBy('messageTime',descending: true).snapshots(),
        builder: (ctx,snapShot) {
          if(snapShot.connectionState==ConnectionState.waiting){
            return const CircularProgressIndicator();
          }

          final documents=snapShot.data!.docs;
          final user= FirebaseAuth.instance.currentUser;
          return ListView.builder(
            reverse:true,
            itemCount: documents.length,
            itemBuilder: (ctx,index){

              return MessageBubble(
               documents[index]['text'],
                documents[index]['username'],
                documents[index]['userId']==user!.uid,
                key: ValueKey(documents[index].id),
              );
            },
          );
        }
    );
  }
}
