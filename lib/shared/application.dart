import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wol_pro_1/Refugee/applications/all_applications.dart';
import 'package:wol_pro_1/services/auth.dart';
import 'constants.dart';



var count = 0;

String status = "Sent to volunteer";
String volID = "";

class Application extends StatefulWidget {
  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var id;
  var ID;
  final List<String> categories = [
    'Choose category',
    'Accomodation',
    'Transfer',
    'Assistance with animals'
  ];
  String title = '';
  String currentCategory = '';
  String comment = '';

  final height = 100;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              'logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Container(
          color: Colors.blue[100],
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Title'),
                  validator: (val) => val!.isEmpty ? 'Enter the title' : null,
                  onChanged: (val) {
                    setState(() => title = val);
                  },
                ),
              ),

              //dropdown
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DropdownButtonFormField(
                  value: categories[0],
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      currentCategory = val.toString();
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextFormField(
                  maxLines: height ~/ 20,
                  decoration: textInputDecoration.copyWith(hintText: 'Comment'),
                  validator: (val) => val!.isEmpty ? 'Enter the comment' : null,
                  onChanged: (val) {
                    setState(() => comment = val);
                  },
                ),
              ),
              RaisedButton.icon(
                  icon: Icon(Icons.add),
                  color: Colors.pink[400],
                  label: Text(
                    'Add new application',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    ID = FirebaseAuth.instance.currentUser?.uid;
                    await FirebaseFirestore.instance
                        .collection('applications')
                        .add({
                      'title': (title == Null)?("Title"):(title),
                      'category': (currentCategory==Null)?("Category"):(currentCategory),
                      'comment': (comment==Null)?("Comment"):(comment),
                      'status': status,
                      'userID': ID,
                      'volunteerID': volID,
                      'date': "null"
                      //'volunteer_pref': currentCategory,

                     // 'userId': FirebaseFirestore.instance.collection('applications').doc().id,
                    });


                    //FirebaseAuth.instance.currentUser?.uid;
                  }),
            ],
          )),
    );
  }
}
