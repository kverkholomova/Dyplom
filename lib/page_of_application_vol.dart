

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/screens/home/home_vol.dart';
import 'package:wol_pro_1/shared/application.dart';

class PageOfApplication extends StatefulWidget {
  const PageOfApplication({Key? key}) : super(key: key);

  @override
  State<PageOfApplication> createState() => _PageOfApplicationState();
}

class _PageOfApplicationState extends State<PageOfApplication> {

  var id = "";

  String status_updated='Application is accepted';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('applications')

              .where('title', isEqualTo: card_title)
          .where('category', isEqualTo: card_category)
          .where('comment', isEqualTo: card_comment)

          //.where("category", whereIn: ['Accomodation','Transfer','Assistance with animals'])
          //.where("category", arrayContainsAny: ['Accomodation','Transfer','Assistance with animals'])
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            return Container(
              width: 350,
              height: 300,
              child: ListView.builder(
                  itemCount: streamSnapshot.data?.docs.length,
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                streamSnapshot.data?.docs[index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black,),textAlign: TextAlign.center,
                              ),
                              Text(
                                  streamSnapshot.data?.docs[index]
                                  ['category'],
                                  style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),
                              Text(streamSnapshot.data?.docs[index]
                              ['comment'],style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,
                              ),
                              Text(streamSnapshot.data?.docs[index]
                              ['status'],style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,
                              ),
                              MaterialButton(

                                  color: Colors.black,
                                  onPressed: () {

                                    FirebaseFirestore.instance
                                        .collection('applications')
                              .doc(streamSnapshot.data?.docs[index].id).update({"status": status_updated});

                                    print(streamSnapshot.data?.docs[index].id);
                                   print("AAAAAAAAAAA ${FirebaseFirestore.instance
                                    .collection('applications').doc().id}");
                                        //.then((QuerySnapshot querySnapshot) {
                                      //querySnapshot.docs.forEach((doc) { print(doc.id);});
                                    //});
                                    //.doc(id).update({"status": status_updated});

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PageOfApplication()),
                                    );

                              })
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
