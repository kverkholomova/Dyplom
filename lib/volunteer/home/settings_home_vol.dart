

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/Refugee/applications/application_info.dart';
import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';


List? categories_user;
class SettingsHomeVol extends StatefulWidget {
  const SettingsHomeVol({Key? key}) : super(key: key);

  @override
  State<SettingsHomeVol> createState() => _SettingsHomeVolState();
}


class _SettingsHomeVolState extends State<SettingsHomeVol> {

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
                  categories_user = streamSnapshot.data?.docs[index]['category'];
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

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories()));
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