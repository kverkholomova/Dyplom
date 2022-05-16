import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

import '../../notification_api.dart';
import 'all_applications.dart';

String IDVolOfApplication = '';
// String? token;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseMessaging _fcm = FirebaseMessaging.instance;

class PageOfApplicationRef extends StatefulWidget {
  const PageOfApplicationRef({Key? key}) : super(key: key);

  @override
  State<PageOfApplicationRef> createState() => _PageOfApplicationRefState();
}

class _PageOfApplicationRefState extends State<PageOfApplicationRef> {

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";

  @override
  void initState() {
    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    getToken();

    FirebaseMessaging.instance.subscribeToTopic("Animal");
  }

  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key = AAAADY1uR1I:APA91bEruiKUQtfsFz0yWjEovi9GAF9nkGYfmW9H2lU6jrtdCGw2C1ZdEczYXvovHMPqQBYSrDnYsbhsyk-kcCBi6Wht_YrGcSKXw4vk0UUNRlwN9UdM_4rhmf_6hd_xyAXbBsgyx12L ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Test Body',
              'title': 'Test Title 2'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "$token",
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  void getToken() async {
    token = token_vol;
    // await FirebaseMessaging.instance.getToken().then(
    //         (token) {
    //       setState(() {
    //         token = token;
    //       });
    //     }
    // );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  // User? user = FirebaseAuth.instance.currentUser;
  // static Future<bool> sendFcmMessage(String title, String message, String tokens) async {
  //   try {
  //
  //     var url = 'https://fcm.googleapis.com/fcm/send';
  //     var header = {
  //       "Content-Type": "application/json",
  //       "Authorization":
  //       "key=your_server_key",
  //     };
  //     var request = {
  //       'notification': {'title': title, 'body': message},
  //       'data': {
  //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //         'type': 'COMMENT'
  //       },
  //       'to': tokens
  //     };
  //
  //     return true;
  //   } catch (e, s) {
  //     print(e);
  //     return false;
  //   }
  // }




// String token = '';
//
//   storeNotificationToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     print("------???---------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
//     print(token);
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .set({'token': token}, SetOptions(merge: true));
//     print(
//         "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
//     print(token);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     FirebaseMessaging.instance.getInitialMessage();
//     FirebaseMessaging.onMessage.listen((event) {});
//     storeNotificationToken();
//     FirebaseMessaging.instance.subscribeToTopic('subscription');
//     FirebaseMessaging.onMessage.listen((event) {
//       LocalNotificationService.display(event);
//     });
//   }

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
                  // String? token;
                  // try {
                  //   token = streamSnapshot.data!.docs[index].get('token');
                  //   print(
                  //       "---------------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
                  //   print(token);
                  // } catch (e) {
                  //   print(
                  //       "--------!!$index-------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
                  //   print(e);
                  // }

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
                                // sendFcmMessage("Application changed", "Refugee deleted application", FirebaseFirestore.instance
                                //     .collection('applications')
                                //     .doc(streamSnapshot.data?.docs[index]["token_vol"]) as String);
                               // token = FirebaseFirestore.instance
                               //      .collection('applications')
                               //      .doc(streamSnapshot.data?.docs[index]["token_vol"]) as String?;
                               //
                               //  // NotificationApi.showNotification(
                               //  //
                               //  //     title: "Application was deleted",
                               //  //     body: "Refugee deleted application, so it was removed from the list of your applications"
                               //  // );
                               //
                               //  _fcm.sendMessage(
                               //    to: token,
                               //    data: {
                               //
                               //    }
                               //
                               //  );


                                // FirebaseFirestore.instance.collection('applications').get().then((snapshot) => {
                                // snapshot.docs.forEach((doc){
                                //
                                // const userData = ;
                                //
                                // if (doc.get("category") == "deleted") {
                                // FirebaseMessaging().sendToDevice(userData.deviceToken, {
                                // notification: {
                                // title: 'Notification title', body: 'Notification Body'}
                                // });
                                // }
                                // });
                                // });

                                sendPushMessage();

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
