import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

import 'package:wol_pro_1/volunteer/home/settings_home_vol.dart';


String card_title='';
String card_category='';
String card_comment='';
String userID_vol ='';


class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  State createState() => new CategoriesState();
}

class CategoriesState extends State<Categories> {


  FirebaseFirestore db = FirebaseFirestore.instance;

  bool loading = false;
  final AuthService _auth = AuthService();
  final CollectionReference applications = FirebaseFirestore.instance.collection("applications");

  List<String> cat = [];

  List<String> categories = ["Your categories", "Accomodation", "Transfer", "Assistance with animals"];

 
//   Future<List> Widg() async {
//   List _message = [];
//   _fetchData(List mess) async{
//     db.collection("users").doc(userID_vol).get().then((value) {
//       setState(() {
//         mess.add(value.get("category"));
//         print(mess);
//       });
//
//     });
//   }
//   return await _fetchData(_message);
// }

  // Future<List> _fetchData() async{
  //   List mess = [];
  //   db.collection("users").doc(userID_vol).get().then((value) {
  //     setState(() {
  //       mess.add(value.get("category"));
  //       print(mess);
  //     });
  //   });
  //   return mess;
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   // this should not be done in build method.
  //   _fetchData();
  // }
  List list_cat = [];

  List getList() {
      DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(userID_vol);
      docRef.set("category").toString();
      List data = [];
      data.add(docRef.set("category").toString());
      // docRef.get().then((datasnapshot){
      //     data.add(datasnapshot.get("category"));
      // });
      return data as List;
    }

    @override
    void main() async{

      list_cat = await getList() as List;
    }

  @override

  void initState() {

  }
  Widget build(BuildContext context) {

    // DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(userID_vol);
    // print(docRef);
    print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
    print(list_cat);
    userID_vol = FirebaseAuth.instance.currentUser!.uid;
    List<String> categoriesList = [];
    final CollectionReference users_cat = FirebaseFirestore.instance.collection("users");


    // Future getData() async {
    //   try {
    //     //to get data from a single/particular document alone.
    //     // var temp = await collectionRef.doc("<your document ID here>").get();
    //
    //     // to get data from all documents sequentially
    //     await users_cat.get().then((querySnapshot) {
    //       for (var result in querySnapshot.docs) {
    //         categoriesList.add(result.data());
    //       }
    //     });
    //
    //     return categoriesList;
    //   } catch (e) {
    //     debugPrint("Error - $e");
    //     return e;
    //   }
    // }

    // Future<List<DocumentSnapshot>> getProduceID() async{
    //   var data = await FirebaseFirestore.instance.collection('applications').doc().collection('users').get();
    //   var productId = data.docs;
    //   return productId;
    // }

    Future getList() async{
      DocumentReference docRef = users_cat.doc();
      var data;
      docRef.get().then((datasnapshot){
          data = datasnapshot.get("category");
      });
      return data;
    }

    print("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");



    // array() {
    //   var x = users_cat.where("id_vol", isEqualTo: userID_vol).get().then((
    //       querySnapshot) {
    //     querySnapshot.docs.forEach((result) {
    //       return result.get("category");
    //       // x = result.get("category");
    //       // print(
    //       //     "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHh");
    //       //
    //       // print(
    //       //     "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    //     });
    //   });
    //   return x;
    // }

    var x;

    users_cat.where("id_vol", isEqualTo: userID_vol).get().then((
              querySnapshot) {
            querySnapshot.docs.forEach((result) {

              x = result.get("category");

            });
    });



    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

    print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");

    // print(users_cat.doc().get().then((value) => value.data()));

    totalClasses() async{
      await FirebaseFirestore.instance
        .collection('users')
        .doc(userID_vol)
        .get()
        .then((value) {
          if(value.data()!['category'] == null){
            return value.data();
          }
          else{
            return value.data()!['category'];
          }
          // Access your after your get the data
    });}

    print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
    print(totalClasses());
    // users_cat.where("id_vol", isEqualTo: userID_vol).get()

    // List categories_vol=[];
    // List getData(){
    //   FirebaseFirestore.instance.collection("users").get().then((value) {
    //
    //     // chosen_category = value.docs[1].get("category");
    //     (chosen_category ==[] )?categories_vol=value.docs[1].get("category"):categories_vol=chosen_category;
    //   });
    //   return categories_vol;
    // }

    print(userID_vol);
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
            actions: <Widget>[

              IconButton(
                icon: const Icon(Icons.person,color: Colors.white,),
                //label: const Text('logout',style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  //await _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApplicationsOfVolunteer()),
                  );
                },
              ),

            ],
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(85, 146, 169, 0.8),
              isScrollable: true,
              tabs: [
                Text(categories[0],style: TextStyle(fontSize: 17),),
                Text(categories[1],style: TextStyle(fontSize: 17),),
                Text(categories[2],style: TextStyle(fontSize: 17),),
                Text(categories[3],style: TextStyle(fontSize: 17),),
              ],

            ),
          ),
        body: TabBarView(
          children: [

            StreamBuilder(
              stream:  applications
                  .where("status", isEqualTo: 'Sent to volunteer')
                  .where("category", whereIn: categories_user)
              //  .where("id_vol", isEqualTo: userID_vol)
              // .where("category", whereIn: chosen_category)
              // .where("category", arrayContainsAny: [chosen_category])

              //.where("volunteer_pref", arrayContainsAny: volunteer_preferencies)
              //.where("category", arrayContainsAny: ['Accomodation', 'Transfer', 'Assistance with animals'])

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
                                card_title=streamSnapshot.data?.docs[index]['title'] as String;
                                card_category=streamSnapshot.data?.docs[index]['category'] as String;
                                card_comment=streamSnapshot.data?.docs[index]['comment'] as String;

                                print(card_title);
                                print(card_category);
                                print(card_comment);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageOfApplication()),
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
                                            fontWeight: FontWeight.bold, ),
                                        textAlign: TextAlign.left,
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
            StreamBuilder(
                  stream:   FirebaseFirestore.instance
                      .collection('applications')
                      .where("category", isEqualTo: "Accomodation")

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
                                    card_title=streamSnapshot.data?.docs[index]['title'] as String;
                                    card_category=streamSnapshot.data?.docs[index]['category'] as String;
                                    card_comment=streamSnapshot.data?.docs[index]['comment'] as String;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PageOfApplication()),
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
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('applications')
                  .where("category", isEqualTo: "Transfer")

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
                              card_title=streamSnapshot.data?.docs[index]['title'] as String;
                              card_category=streamSnapshot.data?.docs[index]['category'] as String;
                              card_comment=streamSnapshot.data?.docs[index]['comment'] as String;
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageOfApplication()),
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
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('applications')
                  .where("category", isEqualTo: "Assistance with animals")

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
                              card_title=streamSnapshot.data?.docs[index]['title'] as String;
                              card_category=streamSnapshot.data?.docs[index]['category'] as String;
                              card_comment=streamSnapshot.data?.docs[index]['comment'] as String;
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageOfApplication()),
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