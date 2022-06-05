import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/Refugee/home/home_ref.dart';
import 'package:wol_pro_1/services/auth.dart';

import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';

import '../../service/local_push_notifications.dart';

String current_name_Ref = '';
// List? categories_user;
String token_ref ='';
final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseMessaging _fcm = FirebaseMessaging.instance;

class SettingsHomeRef extends StatefulWidget {
  const SettingsHomeRef({Key? key}) : super(key: key);

  @override
  State<SettingsHomeRef> createState() => _SettingsHomeRefState();
}


class _SettingsHomeRefState extends State<SettingsHomeRef> {

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(
        "------???---------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    print(token);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token_ref': token}, SetOptions(merge: true));
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
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
        // elevation: 0.0,
        title: Text('Users Info', style: TextStyle(fontSize: 16),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),

          onPressed: () async {
            await _auth.signOut();
          },
        ),

      ),
      body: Container(
        color: Color.fromRGBO(234, 191, 213, 0.8),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where(
              'id_vol', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            return ListView.builder(
                itemCount: streamSnapshot.data?.docs.length,
                itemBuilder: (ctx, index) {
                  // categories_user =
                  // streamSnapshot.data?.docs[index]['category'];
                  token_ref = streamSnapshot.data?.docs[index]['token_ref'];
                  current_name_Ref =
                  streamSnapshot.data?.docs[index]['user_name'];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          streamSnapshot.data?.docs[index]['user_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,), textAlign: TextAlign.center,
                        ),

                      ),

                      Text(
                        streamSnapshot.data?.docs[index]['phone_number'],
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                        textAlign: TextAlign.center,),


                      // Text(
                      //   streamSnapshot.data?.docs[index]['date'],
                      //   style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),

                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: MaterialButton(
                              color: const Color.fromRGBO(137, 102, 120, 0.8),
                              child: const Text('Applications'),
                              onPressed: () {
                                current_name_Ref =
                                streamSnapshot.data?.docs[index]['user_name'];
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => const HomeRef()));
                              },
                            ),
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 40),
                      //   child: Center(
                      //     child: Container(
                      //       width: 200,
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20)
                      //       ),
                      //       child: MaterialButton(
                      //         color: const Color.fromRGBO(137, 102, 120, 0.8),
                      //         child: const Text('Messages'),
                      //         onPressed: () {
                      //           // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage_3()));
                      //           // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(name: current_name,)));
                      //           // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(name: current_name)));
                      //           // Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(chatRoomId: '',)));
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                });
          },
        ),
      ),

    );
  }
}