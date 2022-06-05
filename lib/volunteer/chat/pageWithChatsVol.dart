import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:wol_pro_1/volunteer/chat/messagesVol.dart';




class ListofChatroomsVol extends StatefulWidget {
  const ListofChatroomsVol({Key? key}) : super(key: key);

  @override
  State<ListofChatroomsVol> createState() => _ListofChatroomsVolState();
}
String? IdOfChatroomVol = '';
List<String?> listOfRefugeesVol_ = [];
class _ListofChatroomsVolState extends State<ListofChatroomsVol> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('USERS_COLLECTION')
            .where('IdVolunteer', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot?> streamSnapshot) {
          return Container(
            width: 450,
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: streamSnapshot.data?.docs.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          listOfRefugeesVol_.add(streamSnapshot.data?.docs[index]["IdRefugee"]);
                          IdOfChatroomVol = streamSnapshot.data?.docs[index]["chatId"];

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectedChatroomVol()),
                          );
                          // print("print ${streamSnapshot.data?.docs[index][id]}");
                        });
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              //streamSnapshot.data?.docs[index]['title']==null ?

                              Text(streamSnapshot.data?.docs[index]['Refugee_Name'])

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}