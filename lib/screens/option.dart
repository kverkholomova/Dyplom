import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/cash/screen_with_applications.dart';
import 'package:wol_pro_1/volunteer/authenticate/register_volunteer.dart';

import 'package:wol_pro_1/screens/wrapper.dart';
import '../shared/loading.dart';
import '../volunteer/authenticate/register_volunteer_1.dart';

var option_refugee=true;

class OptionChoose extends StatefulWidget {
  const OptionChoose({Key? key}) : super(key: key);


  @override
  State<OptionChoose> createState() => _OptionChooseState();
}

class _OptionChooseState extends State<OptionChoose> {

  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print(value);
    });}

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      
      body: Container(
        color: const Color.fromRGBO(234, 191, 213, 0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250,horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: MaterialButton(
                  color: const Color.fromRGBO(137, 102, 120, 0.8),
                  child: const Text('Volunteer'),
                  onPressed: () async{

                    option_refugee=false;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Wrapper()));
                  },
                  ),
                ),
              ),
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
                      child: const Text('Refugee'),
                      onPressed: () {

                        option_refugee=true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Wrapper()));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
