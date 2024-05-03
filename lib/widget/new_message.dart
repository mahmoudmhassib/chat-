import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class NewMessageText extends StatefulWidget {
  const NewMessageText({super.key});

  @override
  State<NewMessageText> createState() => _NewMessageTextState();
}

class _NewMessageTextState extends State<NewMessageText> {
  TextEditingController controllerText=TextEditingController();

  String _enteredMessage='';

   _sendMessage()async{

     if(controllerText.text.isNotEmpty){
       try{
         FocusScope.of(context).unfocus();

         final user= FirebaseAuth.instance.currentUser;
         final userData=await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
         FirebaseFirestore.instance.collection('/chat').add({
           'text':_enteredMessage,
           'messageTime':FieldValue.serverTimestamp().toString(),
           'username':userData['username'],
           'userId':user.uid,
         });
         controllerText.clear();
       } catch(e) {
         print('error');
       }
     }


     /*FirebaseFirestore.instance.collection('/chat/uwgfX5C55SuNrjutZh82/messeges').snapshots().listen((event) {
       event.docs.forEach((element) {
         print(element['text']);
       });});*/
   }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 8),
      padding:const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controllerText,
            decoration:const InputDecoration(labelText: 'send a message ..'),
              onChanged: (newVal){
                setState(() {
                  _enteredMessage=newVal;

                });
              },
            ),
          ),
          IconButton(
            color: Colors.greenAccent,
              onPressed: _enteredMessage.trim().isEmpty?null:_sendMessage,
              icon:const Icon(Icons.send)),
        ],
      ),
    );
  }
}
