
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/Refugee/applications/all_applications.dart';
import 'package:wol_pro_1/chatPage.dart';
import 'package:wol_pro_1/message.dart';
import 'package:wol_pro_1/models/users_all.dart';
import 'package:wol_pro_1/services/auth.dart';
import 'package:wol_pro_1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:wol_pro_1/shared/application.dart';
import 'package:wol_pro_1/volunteer/home/applications_vol.dart';


class HomeRef extends StatefulWidget {
  const HomeRef({Key? key}) : super(key: key);

  @override
  State<HomeRef> createState() => _HomeRefState();
}

class _HomeRefState extends State<HomeRef> {


  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    userID_ref = FirebaseAuth.instance.currentUser!.uid;
  /**  void showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
              child: SettingsForm(),
            );
          });
    }**/

    return StreamProvider<List<AllUsers>?>.value(
      catchError: (_,__) => null,
      value: DatabaseService(uid: '').users,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
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
            /**TextButton.icon(
                onPressed: (){
                  showSettingsPanel();
                },
                label: Text("Settings",style: TextStyle(color: Colors.white),),
                icon: Icon(Icons.settings,color: Colors.white,),)**/
          ],
        ),
        body: Container(

          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton.icon(
                  icon: Icon(Icons.add),
                    color: Colors.pink[400],
                    label: Text(
                      'Add new application',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Application()));
                    }
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton.icon(
                    icon: Icon(Icons.note),
                    color: Colors.pink[400],
                    label: Text(
                      'My applications',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                      print(userID_ref);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesRef()));
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton.icon(
                    icon: Icon(Icons.note),
                    color: Colors.pink[400],
                    label: Text(
                      'Message',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                      print(userID_ref);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(name: "Karina")));
                    }
                ),
              ),
            ],
          ),

    ),
      ),
    );
  }
}

/**
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Refugee>?>.value(
      catchError: (_,__) => null,
      value: DatabaseService(uid: '').users,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.amber,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
        onPressed: () async{
          await _auth.signOut();
        },
            icon: Icon(Icons.person),
                label: Text("Logout"))
          ],
        ),
        body: UserList(),
      ),
    );
  }
}**/
