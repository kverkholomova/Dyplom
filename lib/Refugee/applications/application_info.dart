import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/screens/info_volunteer_accepted_application.dart';
import 'package:wol_pro_1/service/local_push_notifications.dart';
import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';

import 'all_applications.dart';

String IDVolOfApplication = '';

class PageOfApplicationRef extends StatefulWidget {
  const PageOfApplicationRef({Key? key}) : super(key: key);

  @override
  State<PageOfApplicationRef> createState() => _PageOfApplicationRefState();
}

class _PageOfApplicationRefState extends State<PageOfApplicationRef> {
  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("------???---------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    print(token);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
    print(
        "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    print(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {});
    storeNotificationToken();
    FirebaseMessaging.instance.subscribeToTopic('subscription');
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
  }

  final CollectionReference applications =
      FirebaseFirestore.instance.collection('applications');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              .where('title', isEqualTo: card_title_ref)
              .where('category', isEqualTo: card_category_ref)
              .where('comment', isEqualTo: card_comment_ref)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            return ListView.builder(
                itemCount: streamSnapshot.data?.docs.length,
                itemBuilder: (ctx, index) {
                  String? token;
                  try {
                    token = streamSnapshot.data!.docs[index].get('token');
                    print(
                        "---------------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
                    print(token);
                  } catch (e) {
                    print(
                        "--------!!$index-------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
                    print(e);
                  }

                  User? user = FirebaseAuth.instance.currentUser;
                  final docId = streamSnapshot.data!.docs[index]["volunteerID"];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          streamSnapshot.data?.docs[index]['status'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          streamSnapshot.data?.docs[index]['date'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 250, bottom: 20),
                        child: SizedBox(
                          height: 50,
                          width: 300,
                          child: MaterialButton(
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color.fromRGBO(18, 56, 79, 0.8),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('applications')
                                    .doc(streamSnapshot.data?.docs[index].id)
                                    .update({"status": "deleted"});

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => PageOfVolunteerRef()),
                                // );
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: SizedBox(
                          height: 50,
                          width: 300,
                          child: MaterialButton(
                              child: Text(
                                "Look info about volunteer",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color.fromRGBO(18, 56, 79, 0.8),
                              onPressed: () {
                                IDVolOfApplication = streamSnapshot
                                    .data?.docs[index]['volunteerID'] as String;
                                print(IDVolOfApplication);
                                print(
                                    "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PageOfVolunteerRef()),
                                );
                              }),
                        ),
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
