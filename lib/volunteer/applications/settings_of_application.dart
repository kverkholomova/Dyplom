import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wol_pro_1/volunteer/chat/message.dart';
import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';
import 'package:http/http.dart' as http;
import '../../Refugee/SettingRefugee.dart';

String roomExist ='';
// bool isvisible = true;
String? IdOfChatroom = '';
String VoluntterName = '';
String RefugeeName = '';

class SettingsOfApplication extends StatefulWidget {
  const SettingsOfApplication({Key? key}) : super(key: key);

  @override
  State<SettingsOfApplication> createState() => _SettingsOfApplicationState();
}

List<String> users_chat = [];
var ID_of_vol_application;
String? appId = '';

class _SettingsOfApplicationState extends State<SettingsOfApplication> {

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";

  @override
  void initState() {
    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    // getToken();

    FirebaseMessaging.instance.subscribeToTopic("Animal");
  }

  void sendPushMessage() async {
    print("SSSSSSSSSSSSSSSSSSSsEEEEEEEEEENNNNNNNNNNNNNNNNNNNNDDDDDDDDDDDDDDDDDDDDD");
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key = AAAADY1uR1I:APA91bEruiKUQtfsFz0yWjEovi9GAF9nkGYfmW9H2lU6jrtdCGw2C1ZdEczYXvovHMPqQBYSrDnYsbhsyk-kcCBi6Wht_YrGcSKXw4vk0UUNRlwN9UdM_4rhmf_6hd_xyAXbBsgyx12L  ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Volunteer has decided to decline your application',
              'title': 'Acceptance decline'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "$token_ref",
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
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
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
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
                              child: Visibility(
                                visible: streamSnapshot.data?.docs[index]["mess_button_visibility"],
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
                                      // RefugeeName = streamSnapshot.data?.docs[index][]
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
                                         // users_chat.add(streamSnapshot
                                         //     .data?.docs[index]['userID']);
                                         // users_chat.add(streamSnapshot
                                         //     .data?.docs[index]["volunteerID"]);
                                         // print(
                                         //     "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
                                         // print(users_chat);
                                         // Navigator.push(
                                         //   context,
                                         //   MaterialPageRoute(
                                         //       builder: (context) => SelectedChatroom()),
                                         // );
                                         // FirebaseFirestore.instance.collection('USERS_COLLECTION').doc().set({
                                         //   "chat_date_time": DateTime.now().day,
                                         // });


                                         // idc = FirebaseFirestore.instance.collection('USERS_COLLECTION').doc().get()

                                         IdOfChatroom = FirebaseFirestore.instance.collection('USERS_COLLECTION').doc().id;
                                         print("PPPPPPPPPPPPPPPPPPPOOOOOOOOOOOOOOOOWWWWWWWWWWWWWWWWWWWWW");
                                         print(IdOfChatroom);
                                         FirebaseFirestore.instance
                                             .collection('USERS_COLLECTION')
                                             .doc(IdOfChatroom)
                                             .set({
                                           'IdVolunteer': streamSnapshot
                                               .data?.docs[index]['volunteerID'],
                                           'IdRefugee': streamSnapshot
                                               .data?.docs[index]["userID"],
                                           'chatId': IdOfChatroom,
                                           'Refugee_Name': streamSnapshot
                                               .data?.docs[index]['refugee_name'],
                                           'Volunteer_Name': streamSnapshot
                                               .data?.docs[index]['volunteer_name'],
                                         });



                                         // FirebaseFirestore.instance
                                         //     .collection('applications')
                                         //     .doc(IdOfChatroom)
                                         //     .update({
                                         //   // 'IdVolunteer': streamSnapshot
                                         //   //     .data?.docs[index]['userID'],
                                         //   // 'IdRefugee': streamSnapshot
                                         //   //     .data?.docs[index]["volunteerID"],
                                         //   'chatId': IdOfChatroom,
                                         // });

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
                                      //LOOOOK HEEEEREEEEE
                                       FirebaseFirestore.instance
                                          .collection('applications')
                                          .doc(
                                          streamSnapshot.data?.docs[index].id)
                                          .update({"mess_button_visibility": false});

                                       // else{
                                       //
                                       //   Navigator.push(
                                       //     context,
                                       //     MaterialPageRoute(
                                       //         builder: (context) =>
                                       //             ListofChatroomsVol()),
                                       //   );
                                       // }




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
                                    sendPushMessage();
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
