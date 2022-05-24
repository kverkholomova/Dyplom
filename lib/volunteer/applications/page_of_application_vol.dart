

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';
import 'package:wol_pro_1/volunteer/home/settings_home_vol.dart';

import '../../service/local_push_notifications.dart';

String date = '';

// DateTime date = DateTime.now();
class PageOfApplication extends StatefulWidget {
  const PageOfApplication({Key? key}) : super(key: key);

  @override
  State<PageOfApplication> createState() => _PageOfApplicationState();
}

var ID_of_vol_application;
class _PageOfApplicationState extends State<PageOfApplication> {

  // DocumentReference<Map<String, dynamic>> token_vol = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(userID_vol).;
  //

  // storeNotificationToken() async {
  //   String? token_vol = await FirebaseMessaging.instance.getToken();
  //   print("------???---------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
  //   print(token_vol);
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .set({'token': token_vol}, SetOptions(merge: true));
  //   print(
  //       "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
  //   print(token_vol);
  //   return token_vol;
  // }
  //
  // String token_vol = '';
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   FirebaseMessaging.instance.getInitialMessage();
  //   FirebaseMessaging.onMessage.listen((event) {});
  //   storeNotificationToken();
  //   FirebaseMessaging.instance.subscribeToTopic('subscription');
  //   FirebaseMessaging.onMessage.listen((event) {
  //     LocalNotificationService.display(event);
  //   });
  // }

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
                                    date = DateTime.now().toString();
                                    FirebaseFirestore.instance
                                        .collection('applications')
                                        .doc(streamSnapshot.data?.docs[index].id).update({"status": status_updated});
                                    FirebaseFirestore.instance
                                        .collection('applications')
                                        .doc(streamSnapshot.data?.docs[index].id).update({"volunteerID": volID});
                                    FirebaseFirestore.instance
                                        .collection('applications')
                                        .doc(streamSnapshot.data?.docs[index].id).update({"date": date});
                                    FirebaseFirestore.instance
                                        .collection('applications')
                                        .doc(streamSnapshot.data?.docs[index].id).update({"token_vol": token_vol});

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
