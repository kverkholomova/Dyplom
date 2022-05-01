

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';


class PageOfApplication extends StatefulWidget {
  const PageOfApplication({Key? key}) : super(key: key);

  @override
  State<PageOfApplication> createState() => _PageOfApplicationState();
}

var ID_of_vol_application;
class _PageOfApplicationState extends State<PageOfApplication> {

  //var id = "";

  String status_updated='Application is accepted';
  String volID = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
        elevation: 0.0,
        title: Text('Application Info',style: TextStyle(fontSize: 16),),

      ),
      body: Container(
          color: Color.fromRGBO(234, 191, 213, 0.8),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('applications')
                .where('title', isEqualTo: card_title)
                .where('category', isEqualTo: card_category)
                .where('comment', isEqualTo: card_comment)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              return ListView.builder(
                  itemCount: streamSnapshot.data?.docs.length,
                  itemBuilder: (ctx, index) =>
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              streamSnapshot.data?.docs[index]['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black,),textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                              streamSnapshot.data?.docs[index]['category'],
                              style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(streamSnapshot.data?.docs[index]['comment'],style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 350,bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 300,
                              child: MaterialButton(
                                  child: Text("Accept",style: TextStyle(color: Colors.white),),
                                  color: Color.fromRGBO(18, 56, 79, 0.8),

                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('applications')
                                        .doc(streamSnapshot.data?.docs[index].id).update({"status": status_updated});
                                    FirebaseFirestore.instance
                                        .collection('applications')
                                        .doc(streamSnapshot.data?.docs[index].id).update({"volunteerID": volID});

                                    print(streamSnapshot.data?.docs[index].id);
                                   print("AAAAAAAAAAA ${FirebaseFirestore.instance
                                    .collection('applications').doc().id}");

                                   ID_of_vol_application=streamSnapshot.data?.docs[index].id;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ApplicationsOfVolunteer()),
                                    );

                              }
                              ),
                            ),
                          )
                        ],
                      ));
            },
          ),
        ),

    );
  }
}
