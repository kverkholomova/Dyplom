

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/Refugee/applications/application_info.dart';
import 'package:wol_pro_1/volunteer/applications/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';



class PageOfVolunteerRef extends StatefulWidget {
  const PageOfVolunteerRef({Key? key}) : super(key: key);

  @override
  State<PageOfVolunteerRef> createState() => _PageOfVolunteerRefState();
}


class _PageOfVolunteerRefState extends State<PageOfVolunteerRef> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
        elevation: 0.0,
        title: Text('Application Info',style: TextStyle(fontSize: 16),),

      ),
      body: Container(
        color: Color.fromRGBO(234, 191, 213, 0.8),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('id_vol', isEqualTo: IDVolOfApplication)
              .snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            return ListView.builder(
                itemCount: streamSnapshot.data?.docs.length,
                itemBuilder: (ctx, index) =>
                    Column(
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


                        Padding(
                          padding: const EdgeInsets.only(top: 350,bottom: 20),
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: MaterialButton(
                                child: Text("Look info about volunteer",style: TextStyle(color: Colors.white),),
                                color: Color.fromRGBO(18, 56, 79, 0.8),

                                onPressed: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ApplicationsOfVolunteer()),
                                  );

                                }
                            ),
                          ),
                        )
                      ],
                    ));
          },
        ),
      ),

    );
  }
}