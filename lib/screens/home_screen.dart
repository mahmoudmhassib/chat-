import 'package:chatfirebase/screens/sign_in.dart';
import 'package:chatfirebase/widget/message.dart';
import 'package:chatfirebase/widget/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
            icon:const Icon(Icons.more_vert),
            items:const [
              DropdownMenuItem(
                value: 'Logout',
                  child:
              Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 3,),
                  Text('Logout'),
                ],
              )),
            ],
            onChanged:(itemIdentifier){
              if(itemIdentifier=='Logout'){
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const SignInScreen()));
              }
            },
          ),
        ],
      ),
      body:const Column(
        children: [
          Expanded(child: MessageText()),
          NewMessageText(),
        ],
      ),
      /*StreamBuilder(
        stream:FirebaseFirestore.instance.collection('/chat').orderBy('messageTime',descending: true).snapshots(),
        builder: (ctx,snapShot){
          if(snapShot.connectionState==ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          final documents=snapShot.data!.docs;
          final user= FirebaseAuth.instance.currentUser;
         return SizedBox(
           width: double.infinity,
           height: MediaQuery.of(context).size.height *.95,
           child: ListView.builder(
             reverse: true,
             itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                MessageBubble(
                documents[index]['text'],
                  documents[index]['username'],
                  documents[index]['userId']==user!.uid,
                  key: ValueKey(documents[index].id),
                ),
                   // NewMessageText(),
                ],
                );
              },
            ),
         );
        },
      ),*/
 /*     floatingActionButton: FloatingActionButton(
        onPressed: (){
          ///listening data
          FirebaseFirestore.instance.collection('/chat/uwgfX5C55SuNrjutZh82/messeges').snapshots().listen((event) {
            event.docs.forEach((element) {
              print(element['text']);
            });

          });
          ///add new data
          FirebaseFirestore.instance.collection('/chat/xhD1zGoTmBqjj9s1lkD4').add({
            'text':'king',
          });
        },
        child: Icon(Icons.add),
      ),*/
     // bottomNavigationBar:NewMessageText(),
      /*Container(
        margin:const EdgeInsets.only(top: 8),
        padding:const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
               // controller: controllerText,
                decoration:const InputDecoration(labelText: 'send a message ..'),
                onChanged: (newVal){
                 *//* setState(() {
                    _enteredMessage=newVal;
                  });*//*
                },
              ),
            ),
            IconButton(
                color: Colors.greenAccent,
                onPressed: (){},
                onPressed: _enteredMessage.trim().isEmpty?null:_sendMessage,
                icon:const Icon(Icons.send)),
          ],
        ),
      ),*/
    );
  }
}
