import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/page_of_application_vol.dart';
import 'package:wol_pro_1/screens/option.dart';
import 'package:wol_pro_1/services/auth.dart';
import 'package:wol_pro_1/shared/application.dart';

String card_title='';
String card_category='';
String card_comment='';

class Categories extends StatefulWidget {
  @override
  State createState() => new CategoriesState();
}

class CategoriesState extends State<Categories> {

  final AuthService _auth = AuthService();
  List<String> categories = ["Your categories", "Accomodation", "Transfer", "Assistance with animals"];

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
              icon: const Icon(Icons.arrow_back,color: Colors.white,),

              onPressed: () async {
                await _auth.signOut();
              },
            ),
            actions: <Widget>[

              TextButton.icon(
                icon: const Icon(Icons.person,color: Colors.white,),
                label: const Text('logout',style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  await _auth.signOut();
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
              stream: FirebaseFirestore.instance
                  .collection('applications')
              .where("category", whereIn: chosen_category)
              //.where("category", arrayContainsAny: [chosen_category])
              
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