
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/models/users_all.dart';
import 'package:wol_pro_1/services/auth.dart';
import 'package:wol_pro_1/services/database.dart';
import 'package:provider/provider.dart';

import 'package:wol_pro_1/shared/application.dart';


class HomeRef extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

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
