import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/Refugee/pageWithChats.dart';
import 'package:wol_pro_1/pageWithChatsVol.dart';
import 'package:wol_pro_1/select_chatroom.dart';
import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/authenticate/register_volunteer_1.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';

bool exist = false;
String? IdOfChatroom = '';
String? VoluntterName = '';
String? RefugeeName = '';

class SettingsOfApplication extends StatefulWidget {
  const SettingsOfApplication({Key? key}) : super(key: key);

  @override
  State<SettingsOfApplication> createState() => _SettingsOfApplicationState();
}

List<String> users_chat = [];
var ID_of_vol_application;
String? appId = '';

class _SettingsOfApplicationState extends State<SettingsOfApplication> {
  //var id = "";

  // static Future<String?> checkExist(String docID) async {
  //   // String? answer = 'Id';
  //   // StreamBuilder(
  //   //     stream: FirebaseFirestore.instance.collection('USERS_COLLECTION')
  //   //         .where('IdVolunteer', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
  //   //         .where("IdRefugee", isEqualTo: docID)
  //   //         .snapshots(),
  //   //     builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
  //   //
  //   //       return ListView.builder(
  //   //           itemCount: streamSnapshot.data?.docs.length,
  //   //           itemBuilder: (ctx, index) {
  //   //       // answer = streamSnapshot.data?.docs[index].id
  //   //             // Con;}
  //   //
  //   //       );});
  //
  //   // var answer = await FirebaseFirestore.instance.collection('USERS_COLLECTION')
  //   //     .where('IdVolunteer', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
  //   //     .where("IdRefugee", isEqualTo: docID)
  //   //     .snapshots();
  //   //
  //   // answer.
  //
  //   // return await answer;
  //
  //   // If any error
  // }

  // @override
  // Widget stream(BuildContext context, String indexDoc) {
  //   return StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection('USERS_COLLECTION')
  //           .where('IdVolunteer', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
  //           // .where("IdRefugee", isEqualTo: FirebaseFirestore.instance.collection("applications").)
  //           .snapshots(),
  //       builder: (context, AsyncSnapshot<QuerySnapshot?> streamSnapshot) {
  //         return Container(
  //           width: 450,
  //           height: 300,
  //           child: ListView.builder(
  //               scrollDirection: Axis.vertical,
  //               itemCount: streamSnapshot.data?.docs.length,
  //               itemBuilder: (ctx, index) =>

  // Column(
  //   children: [
  //     // Card(
  //     //   child: Padding(
  //     //     padding: const EdgeInsets.all(8.0),
  //     //     child: Column(
  //     //       children: [
  //     //         //streamSnapshot.data?.docs[index]['title']==null ?
  //     //
  //     //         Text(streamSnapshot.data?.docs[index]['IdRefugee'])
  //     //
  //     //       ],
  //     //     ),
  //     //   ),
  //     // ),
  //   ],
  // )),
  //         );
  //       },
  //   );
  // }

  String status_declined = 'Sent to volunteer';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Categories()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
          elevation: 0.0,
          title: Text(
            'Application Info',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Container(
          color: Color.fromRGBO(234, 191, 213, 0.8),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('applications')
                .where('title', isEqualTo: card_title_accepted)
                .where('category', isEqualTo: card_category_accepted)
                .where('comment', isEqualTo: card_comment_accepted)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              return ListView.builder(
                  itemCount: streamSnapshot.data?.docs.length,
                  itemBuilder: (ctx, index) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              streamSnapshot.data?.docs[index]['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            streamSnapshot.data?.docs[index]['category'],
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                              streamSnapshot.data?.docs[index]['comment'],
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 250, bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 300,
                              child: MaterialButton(
                                  child: Text(
                                    "Message",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color.fromRGBO(18, 56, 79, 0.8),
                                  onPressed: () {
                                    print(
                                        "JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ");
                                    print(users_chat);
                                    appId = streamSnapshot.data?.docs[index].id;
                                    // if (users_chat != []) {
                                    //   for (int i = 0;
                                    //       i <= users_chat.length;
                                    //       i++) {
                                    //     if (users_chat[i] ==
                                    //         streamSnapshot.data?.docs[index]
                                    //             ['userID']) {
                                    //       if (users_chat[i] ==
                                    //           streamSnapshot.data?.docs[index]
                                    //               ['volunteerID']) {
                                    //         Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) =>
                                    //                   ListofChatroomsVol()),
                                    //         );
                                    //       }
                                    //     } else {
                                    //       users_chat.add(streamSnapshot
                                    //           .data?.docs[index]['userID']);
                                    //       users_chat.add(streamSnapshot.data
                                    //           ?.docs[index]["volunteerID"]);
                                    //       print(
                                    //           "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
                                    //       print(users_chat);
                                    //       // Navigator.push(
                                    //       //   context,
                                    //       //   MaterialPageRoute(
                                    //       //       builder: (context) => SelectedChatroom()),
                                    //       // );
                                    //
                                    //       IdOfChatroom = FirebaseFirestore
                                    //           .instance
                                    //           .collection('USERS_COLLECTION')
                                    //           .doc()
                                    //           .id;
                                    //
                                    //       // idc = FirebaseFirestore.instance.collection('USERS_COLLECTION').doc().get()
                                    //
                                    //       FirebaseFirestore.instance
                                    //           .collection('USERS_COLLECTION')
                                    //           .doc(IdOfChatroom)
                                    //           .set({
                                    //         'IdVolunteer': streamSnapshot
                                    //             .data?.docs[index]['userID'],
                                    //         'IdRefugee': streamSnapshot.data
                                    //             ?.docs[index]["volunteerID"],
                                    //         'chatId': IdOfChatroom,
                                    //       });
                                    //
                                    //       // VoluntterName = FirebaseFirestore.instance.collection("users").doc(users_chat[1]).get() as String;
                                    //       // RefugeeName = FirebaseFirestore.instance.collection("users").where("id_vol", isEqualTo: users_chat[0]).get() as String;
                                    //       Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 SelectedChatroom()),
                                    //       );
                                    //     }
                                    //   }
                                    // } else
                                    //   if(users_chat == []) {

                                     if (streamSnapshot.data?.docs[index]["chatId_vol"] == "null"){
                                       users_chat.add(streamSnapshot
                                           .data?.docs[index]['userID']);
                                       users_chat.add(streamSnapshot
                                           .data?.docs[index]["volunteerID"]);
                                       print(
                                           "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
                                       print(users_chat);
                                       // Navigator.push(
                                       //   context,
                                       //   MaterialPageRoute(
                                       //       builder: (context) => SelectedChatroom()),
                                       // );

                                       IdOfChatroom = FirebaseFirestore.instance.collection('USERS_COLLECTION').doc().id;

                                       // idc = FirebaseFirestore.instance.collection('USERS_COLLECTION').doc().get()

                                       FirebaseFirestore.instance
                                           .collection('USERS_COLLECTION')
                                           .doc(IdOfChatroom)
                                           .set({
                                         'IdVolunteer': streamSnapshot
                                             .data?.docs[index]['volunteerID'],
                                         'IdRefugee': streamSnapshot
                                             .data?.docs[index]["userID"],
                                         'chatId': IdOfChatroom,
                                       });

                                       FirebaseFirestore.instance
                                           .collection('applications')
                                           .doc(IdOfChatroom)
                                           .set({
                                         'IdVolunteer': streamSnapshot
                                             .data?.docs[index]['userID'],
                                         'IdRefugee': streamSnapshot
                                             .data?.docs[index]["volunteerID"],
                                         'chatId': IdOfChatroom,
                                       });

                                       FirebaseFirestore.instance
                                           .collection('applications')
                                           .doc(
                                           streamSnapshot.data?.docs[index].id)
                                           .update({"chatId_vol": IdOfChatroom});

                                       // VoluntterName = FirebaseFirestore.instance.collection("users").doc(users_chat[1]).get() as String;
                                       // RefugeeName = FirebaseFirestore.instance.collection("users").where("id_vol", isEqualTo: users_chat[0]).get() as String;
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 SelectedChatroom()),
                                       );
                                     }
                                     else{
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 ListofChatroomsVol()),
                                       );
                                     }




                                    //   users_chat.add(streamSnapshot
                                    //       .data?.docs[index]['userID']);
                                    //   users_chat.add(streamSnapshot
                                    //       .data?.docs[index]["volunteerID"]);
                                    //   print(
                                    //       "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
                                    //   print(users_chat);
                                    //   // Navigator.push(
                                    //   //   context,
                                    //   //   MaterialPageRoute(
                                    //   //       builder: (context) => SelectedChatroom()),
                                    //   // );
                                    //
                                    //   IdOfChatroom = FirebaseFirestore.instance.collection('USERS_COLLECTION').doc().id;
                                    //
                                    //   // idc = FirebaseFirestore.instance.collection('USERS_COLLECTION').doc().get()
                                    //
                                    //   FirebaseFirestore.instance
                                    //       .collection('USERS_COLLECTION')
                                    //       .doc(IdOfChatroom)
                                    //       .set({
                                    //     'IdVolunteer': streamSnapshot
                                    //         .data?.docs[index]['userID'],
                                    //     'IdRefugee': streamSnapshot
                                    //         .data?.docs[index]["volunteerID"],
                                    //     'chatId': IdOfChatroom,
                                    //   });
                                    //
                                    // FirebaseFirestore.instance
                                    //     .collection('applications')
                                    //     .doc(IdOfChatroom)
                                    //     .set({
                                    //   'IdVolunteer': streamSnapshot
                                    //       .data?.docs[index]['userID'],
                                    //   'IdRefugee': streamSnapshot
                                    //       .data?.docs[index]["volunteerID"],
                                    //   'chatId': IdOfChatroom,
                                    // });
                                    //
                                    // FirebaseFirestore.instance
                                    //     .collection('applications')
                                    //     .doc(
                                    //     streamSnapshot.data?.docs[index].id)
                                    //     .update({"chatId_vol": IdOfChatroom});
                                    //
                                    //   // VoluntterName = FirebaseFirestore.instance.collection("users").doc(users_chat[1]).get() as String;
                                    //   // RefugeeName = FirebaseFirestore.instance.collection("users").where("id_vol", isEqualTo: users_chat[0]).get() as String;
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             SelectedChatroom()),
                                    //   );









                                    // }

                                    // VoluntterName = FirebaseFirestore.instance.collection("users").where("id_vol", isEqualTo: users_chat[1]) as String?;
                                    // RefugeeName = FirebaseFirestore.instance.collection("users").where("id_vol", isEqualTo: users_chat[0]) as String?;
                                  }
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50, bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 300,
                              child: MaterialButton(
                                  child: Text(
                                    "Decline",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color.fromRGBO(18, 56, 79, 0.8),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('applications')
                                        .doc(
                                            streamSnapshot.data?.docs[index].id)
                                        .update({"status": status_declined});

                                    print(streamSnapshot.data?.docs[index].id);
                                    print(
                                        "AAAAAAAAAAA ${FirebaseFirestore.instance.collection('applications').doc().id}");

                                    ID_of_vol_application =
                                        streamSnapshot.data?.docs[index].id;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ApplicationsOfVolunteer()),
                                    );
                                  }),
                            ),
                          )
                        ],
                      ));
            },
          ),
        ),
      ),
    );
  }
}
