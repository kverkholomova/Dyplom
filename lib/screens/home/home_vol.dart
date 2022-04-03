
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wol_pro_1/shared/loading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../services/auth.dart';
import '../../shared/application.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: HomeVol(),
    );
  }
}

class HomeVol extends StatelessWidget {
  CollectionReference appl = FirebaseFirestore.instance.collection('applications');
  final AuthService _auth = AuthService();



  String val_data='';

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  //String currentId=id.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.brown[400],
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                RaisedButton(
                  child: Text("Accom"),
                  onPressed: () {
                    chosen_category="Accomodation";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeVol()));
                  },
                ),
                RaisedButton(
                  child: Text("Trans"),
                  onPressed: () {
                    chosen_category="Transfer";
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeVol()));
                  },
                ),
                RaisedButton(
                  child: Text("Anim"),
                  onPressed: () {
                    chosen_category="Assistance with animals";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeVol()));

                  },

                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('applications')
                  .where("category", isEqualTo: chosen_category)
                  .snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                return Container(
                  width: 350,
                  height: 300,
                  child: ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (ctx, index) =>

                    Column(
                      children: [
                        Card(
                          child: Column(
                            children: [

                              Text(streamSnapshot.data?.docs[index]['title']),
                              Text(streamSnapshot.data?.docs[index]['category']),
                              Text(streamSnapshot.data?.docs[index]['comment']),

                            ],
                          ),
                        ),

                      ],
                    )

                  ),
                );
              },
            ),
          ),
        ],
      )

      /**FutureBuilder(
        future: FirebaseFirestore.instance
        .collection("applications")

        .get(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          QuerySnapshot<Object?>? documents = snapshot.data;
          List<DocumentSnapshot> docs = documents!.docs;
          docs.forEach((data) {
            data_from_database.add(data.data().toString());
            print(data.data().toString());
            print(data_from_database[0]);
            //_id= data.id;
    });
    }
        else if (snapshot.connectionState == ConnectionState.done) {
          Loading();
          //Map<String, dynamic> data =
          //snapshot.data?.docs.data() as Map<String, dynamic>;
          return Center(child: Column(
            children: [
              Text(data_from_database[0],style: TextStyle(color: Colors.black),),
            ],
          ));
        }
    return Container(
        child: Text(data_from_database[0].toString(),style: TextStyle(color: Colors.black),),
    );

    })**/

    /**FutureBuilder<DocumentSnapshot>(
        future: appl.doc("X6203dvoRQxRmyFUoKut").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Loading();
          }

          print("${!snapshot.hasData} ${!snapshot.data!.exists}"); // always "false true"
          if (!snapshot.hasData && !snapshot.data!.exists) {

            return Loading();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Loading();
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
            return Center(child: Column(
              children: [
                Card(
                    child: Column(
                      children: [
                        Text(data['title']),
                        Text(data['category']),
                        Text(data['comment']),
                      ],
                    )),
              ],
            ));
          }

          return Loading();
        },
      ),**/
    );
  }
}












