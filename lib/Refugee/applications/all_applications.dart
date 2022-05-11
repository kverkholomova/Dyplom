import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:wol_pro_1/volunteer/applications/page_of_application_vol.dart';
import 'package:wol_pro_1/volunteer/authenticate/register_volunteer.dart';
import 'package:wol_pro_1/volunteer/authenticate/register_volunteer_1.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';
import 'package:wol_pro_1/screens/option.dart';
import 'package:wol_pro_1/cash/register_form.dart';
import 'package:wol_pro_1/services/auth.dart';
import 'package:wol_pro_1/shared/application.dart';
import 'package:wol_pro_1/shared/loading.dart';
import 'dart:async';

import 'application_info.dart';

String application_ID = '';
String card_title_ref='';
String card_category_ref='';
String card_comment_ref='';

String userID_ref = '';

class CategoriesRef extends StatefulWidget {
  const CategoriesRef({Key? key}) : super(key: key);
  @override
  State createState() => new CategoriesRefState();
}

class CategoriesRefState extends State<CategoriesRef> {

  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState(){
    super.initState();
    loadFCM();
    listenFCM();
    getToken();
  }

  void getToken() async{
    await FirebaseMessaging.instance.getToken().then((token) {
      print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
      print(token);});
  }
  void listenFCM() async{
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


  void loadFCM()async{
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



  bool loading = false;
  final AuthService _auth = AuthService();
  List<String> categories = ["Accepted", "Queue"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OptionChoose()),
        );
        return true;
      },
      child: DefaultTabController(

        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app,color: Colors.white,),
              onPressed: () async {
                await _auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OptionChoose()),
                );
              },
            ),

            bottom: TabBar(
              indicatorColor: Color.fromRGBO(85, 146, 169, 0.8),
              isScrollable: true,
              tabs: [
                Text(categories[0],style: TextStyle(fontSize: 17),),
                Text(categories[1],style: TextStyle(fontSize: 17),),
              ],

            ),
          ),
          body: TabBarView(
            children: [

              StreamBuilder(
                stream: FirebaseFirestore.instance

                    .collection('applications')
                    .where('userID', isEqualTo: userID_ref)



                //.where("volunteer_pref", arrayContainsAny: volunteer_preferencies)
                //.where("category", arrayContainsAny: ['Accomodation', 'Transfer', 'Assistance with animals'])
                    .where("status", isEqualTo: 'Application is accepted')



                //.where("category", whereIn: ['Accomodation','Transfer','Assistance with animals'])
                //.where("category", arrayContainsAny: ['Accomodation','Transfer','Assistance with animals'])
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
                                  card_title_ref=streamSnapshot.data?.docs[index]['title'] as String;
                                  card_category_ref=streamSnapshot.data?.docs[index]['category'] as String;
                                  card_comment_ref=streamSnapshot.data?.docs[index]['comment'] as String;
                                  application_ID = streamSnapshot.data?.docs[index].id as String;
                                  print(card_title_ref);
                                  print(card_category_ref);
                                  print(card_comment_ref);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PageOfApplicationRef()),
                                  );
                                  // print("print ${streamSnapshot.data?.docs[index][id]}");
                                });

                              },
                              child: Card(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        //streamSnapshot.data?.docs[index]['title']==null ?

                                        Text(
                                          streamSnapshot.data?.docs[index]['title'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),//: Text('nic'),
                                        Text(
                                            streamSnapshot.data?.docs[index]
                                            ['category'] as String,
                                            style: TextStyle(color: Colors.grey)),
                                        Text(streamSnapshot.data?.docs[index]
                                        ['comment'] as String),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
              StreamBuilder(
                stream:   FirebaseFirestore.instance
                    .collection('applications')
                    .where('userID', isEqualTo: userID_ref)

                //.where("volunteer_pref", arrayContainsAny: volunteer_preferencies)
                //.where("category", arrayContainsAny: ['Accomodation', 'Transfer', 'Assistance with animals'])
                    .where("status", isEqualTo: 'Sent to volunteer')

                //.where("category", whereIn: ['Accomodation','Transfer','Assistance with animals'])
                //.where("category", arrayContainsAny: ['Accomodation','Transfer','Assistance with animals'])
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
                                  card_title_ref=streamSnapshot.data?.docs[index]['title'] as String;
                                  card_category_ref=streamSnapshot.data?.docs[index]['category'] as String;
                                  card_comment_ref=streamSnapshot.data?.docs[index]['comment'] as String;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PageOfApplicationRef()),
                                  );
                                  // print("print ${streamSnapshot.data?.docs[index][id]}");
                                });

                              },
                              child: Card(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          streamSnapshot.data?.docs[index]['title'] as String,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            streamSnapshot.data?.docs[index]
                                            ['category'] as String,
                                            style: TextStyle(color: Colors.grey)),
                                        Text(streamSnapshot.data?.docs[index]
                                        ['comment'] as String),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}