import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wol_pro_1/volunteer/chat/pageWithChatsVol.dart';

import '../home/settings_home_vol.dart';
final ScrollController _scrollControllerVol_ = ScrollController();

String color = "blue";


class messages_Vol extends StatefulWidget {
  //
  String? name;
  messages_Vol({ required this.name});
  @override
  _messages_VolState createState() => _messages_VolState(name: name);
}
bool loading = true;
class _messages_VolState extends State<messages_Vol> {

  // isLoading(){
  //   var docCheck = FirebaseFirestore.instance.collection('USERS_COLLECTION')
  //       .doc(IdOfChatroomVol).collection("CHATROOMS_COLLECTION");
  //   print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtoooooooooooooooooooooooooo");
  //   print(docCheck);
  //   if ( docCheck != null){
  //
  //     loading = false;
  //   }
  //   else{
  //     print("YEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
  //     loading = true;
  //   }
  // }

  String? name;
  _messages_VolState({ required this.name});
  //
  // Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
  //     .collection('Messages')
  //     // .where("id_of_adressee", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
  //     .orderBy('time')
  //     .snapshots();
  @override
  Widget build(BuildContext context) {

    // return isLoading() ? Loading() :StreamBuilder(
    return Container(
      height: 250,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("USERS_COLLECTION").doc(IdOfChatroomVol).collection("CHATROOMS_COLLECTION")
            .orderBy('time')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSs");
          print(FirebaseAuth.instance.currentUser?.uid);

          if (snapshot.hasError) {
            return Text("Something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            // physics: NeverScrollableScrollPhysics(),
            controller: _scrollControllerVol_,
            // physics: ScrollPhysics(),
            shrinkWrap: true,
            // primary: true,
            itemBuilder: (_, index) {
              QueryDocumentSnapshot qs = snapshot.data!.docs[index];
              Timestamp t = qs['time'];
              DateTime d = t.toDate();
              print(d.toString());
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  // crossAxisAlignment: name == qs['name']
                  //     ? CrossAxisAlignment.end
                  //     : CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 300,
                      color: snapshot.data?.docs[index]["name"] == current_name_Vol ? Colors.blue[100]:Colors.purple[100],
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: snapshot.data?.docs[index]["name"] == current_name_Vol ? Colors.blue:Colors.purple,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          qs['name'],
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                qs['message'],
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              d.hour.toString() + ":" + d.minute.toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SelectedChatroomVol extends StatefulWidget {
  const SelectedChatroomVol({Key? key}) : super(key: key);

  @override
  State<SelectedChatroomVol> createState() => _SelectedChatroomVolState();
}
// String id_users_col = FirebaseFirestore.instance.collection("USERS_COLLECTION").doc().id;
class _SelectedChatroomVolState extends State<SelectedChatroomVol> {

  // String id_users_col = FirebaseFirestore.instance.collection("USERS_COLLECTION").doc().id;

  writeMessages(){
    FirebaseFirestore.instance.collection("USERS_COLLECTION").doc(IdOfChatroomVol).collection("CHATROOMS_COLLECTION").doc().set(
        {
          'message': message.text.trim(),
          'time': DateTime.now(),
          'name': current_name_Vol,
        }
    );
  }

  final TextEditingController message = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.91,
                child: messages_Vol(
                  name: current_name_Vol,
                ),
              ),
              Container(
                color: Colors.white,
                height: 60,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: message,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.purple[100],
                            hintText: 'message',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.purple),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.purple),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {

                          },
                          onSaved: (value) {
                            message.text = value!;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          messages_Vol(name: current_name_Vol,);
                          await Future.delayed(Duration(milliseconds: 200));
                          SchedulerBinding.instance?.addPostFrameCallback((_) {
                            _scrollControllerVol_.animateTo(
                                _scrollControllerVol_.position.maxScrollExtent,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          });
                          if (message.text.isNotEmpty) {
                            writeMessages();
                            // FirebaseFirestore.instance.collection('').doc().set({
                            //   'message': message.text.trim(),
                            //   'time': DateTime.now(),
                            //   // 'name': current_name,
                            // });
                            message.clear();
                          }
                        },
                        icon: Icon(Icons.send_sharp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}



// class ChatPage extends StatefulWidget {
//   // String name;
//   // ChatPage({required this.name});
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   // String name;
//   // _ChatPageState({required this.name});
//
//   final fs = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   final TextEditingController message = new TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             "Chat"
//         ),
//         actions: [
//           // MaterialButton(
//           //   onPressed: () {
//           //     _auth.signOut().whenComplete(() {
//           //       Navigator.pushReplacement(
//           //         context,
//           //         MaterialPageRoute(
//           //           builder: (context) => OptionChoose(),
//           //         ),
//           //       );
//           //     });
//           //   },
//           //   child: Text(
//           //     "signOut",
//           //   ),
//           // ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: MediaQuery
//                   .of(context)
//                   .size
//                   .height * 0.79,
//               child: messages_Vol(
//                 name: "name",
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: message,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.purple[100],
//                       hintText: 'message',
//                       enabled: true,
//                       contentPadding: const EdgeInsets.only(
//                           left: 14.0, bottom: 8.0, top: 8.0),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.purple),
//                         borderRadius: new BorderRadius.circular(10),
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.purple),
//                         borderRadius: new BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (value) {
//
//                     },
//                     onSaved: (value) {
//                       message.text = value!;
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     await Future.delayed(const Duration(milliseconds: 300));
//                     SchedulerBinding.instance?.addPostFrameCallback((_) {
//                       _scrollControllerVol_.animateTo(
//                           _scrollControllerVol_.position.maxScrollExtent,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.fastOutSlowIn);
//                     });
//                     messages_Vol(name: current_name_Vol,);
//                     loading = false;
//                     if (message.text.isNotEmpty) {
//                       fs.collection('Messages').doc().set({
//                         'message': message.text.trim(),
//                         'time': DateTime.now(),
//                         'name': "name",
//                       });
//                       message.clear();
//                     }
//                   },
//                   icon: Icon(Icons.send_sharp),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }