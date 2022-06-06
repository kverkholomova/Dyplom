import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/Refugee/applications/all_applications.dart';
import 'package:wol_pro_1/Refugee/applications/application_info.dart';
import 'package:wol_pro_1/volunteer/chat/chatPage.dart';
import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';

import '../../service/local_push_notifications.dart';
import '../chat/pageWithChatsVol.dart';

String? currentId_set = '';
String current_name_Vol = '';
List? categories_user;
String? token_vol;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseMessaging _fcm = FirebaseMessaging.instance;

class SettingsHomeVol extends StatefulWidget {
  const SettingsHomeVol({Key? key}) : super(key: key);

  @override
  State<SettingsHomeVol> createState() => _SettingsHomeVolState();
}


class _SettingsHomeVolState extends State<SettingsHomeVol> {

  /// Get the token, save it to the database for current user
  // _saveDeviceToken() async {
  //   // Get the current user
  //   // String uid = FirebaseAuth.instance.currentUser!.uid;
  //   // FirebaseUser user = await _auth.currentUser();
  //
  //   // Get the token for this device
  //   String? fcmToken = await _fcm.getToken();
  //
  //   // // Save it to Firestore
  //   // if (fcmToken != null) {
  //   //   var tokens = _db
  //   //       .collection('users')
  //   //       .doc(uid)
  //   //       .collection('tokens')
  //   //       .doc(fcmToken);
  //   //
  //   //   await tokens.set({
  //   //     'token': fcmToken,
  //   //     'createdAt': FieldValue.serverTimestamp(), // optional
  //   //
  //   //   });
  //   // }
  // }

  // String token = '';
  //
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
        elevation: 0.0,
        title: Text('Users Info',style: TextStyle(fontSize: 16),),

      ),
      body: Container(
        color: Color.fromRGBO(234, 191, 213, 0.8),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('id_vol', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            return ListView.builder(
                itemCount: streamSnapshot.data?.docs.length,
                itemBuilder: (ctx, index) {

                  token_vol = streamSnapshot.data?.docs[index]['token'];
                  current_name_Vol = streamSnapshot.data?.docs[index]['user_name'];
                  return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            streamSnapshot.data?.docs[index]['user_name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black,),textAlign: TextAlign.center,
                          ),

                        ),

                        Text(
                          streamSnapshot.data?.docs[index]['phone_number'],
                          style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),



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
                                  categories_user = streamSnapshot.data?.docs[index]['category'];
                                  currentId_set = streamSnapshot.data?.docs[index].id;
                                  current_name_Vol = streamSnapshot.data?.docs[index]['user_name'];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories()));
                                },
                              ),
                            ),
                          ),
                        ),

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
                                child: const Text('Messages'),
                                onPressed: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListofChatroomsVol()),
                                        );
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage_3()));
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(name: current_name,)));
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(name: current_name)));
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(chatRoomId: '',)));
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                });
          },
        ),
      ),

    );
  }
}