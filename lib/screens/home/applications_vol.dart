import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/screen_with_applications.dart';
import 'package:wol_pro_1/settings_of_application.dart';

import '../option.dart';

String card_title_accepted='';
String card_category_accepted='';
String card_comment_accepted='';

class ApplicationsOfVolunteer extends StatefulWidget {
  const ApplicationsOfVolunteer({Key? key}) : super(key: key);

  @override
  State<ApplicationsOfVolunteer> createState() => _ApplicationsOfVolunteerState();
}

class _ApplicationsOfVolunteerState extends State<ApplicationsOfVolunteer> {
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
          leading: IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Categories()),
            );
          }, icon: Icon(Icons.arrow_back),

          ),
          title: Text('Your applications',style: TextStyle(fontSize: 16),),

        ),
        body: Container(
          color: Color.fromRGBO(234, 191, 213, 0.8),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('applications')
                .where("status", isEqualTo: 'Application is accepted')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              return ListView.builder(
                  itemCount: streamSnapshot.data?.docs.length,
                  itemBuilder: (ctx, index) =>
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MaterialButton(
                              onPressed: (){
                                card_title_accepted=streamSnapshot.data?.docs[index]['title'] as String;
                                card_category_accepted=streamSnapshot.data?.docs[index]['category'] as String;
                                card_comment_accepted=streamSnapshot.data?.docs[index]['comment'] as String;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingsOfApplication()),
                                );
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
                          ),


                        ],
                      ));
            },
          ),
        ),
      ),
    );
  }
}


/**RaisedButton.icon(
    icon: Icon(Icons.add,color: Colors.white,),
    color: Color.fromRGBO(234, 191, 213, 0.8),
    onPressed: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => Categories()));

    }, label: Text("Add"),
    ),**/