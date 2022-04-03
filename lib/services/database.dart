import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wol_pro_1/models/user.dart';
import 'package:wol_pro_1/models/users_all.dart';

class DatabaseService{

    final String uid;
    DatabaseService({required this.uid});
    //collection reference
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

    Future updateUserData(String name, String role) async{
      return await userCollection.doc(uid).set({
        'name': name,
        'role': role,
      });
    }

    //users list from snapshot
    List <AllUsers> _refugeeListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.docs.map((doc){
        return AllUsers(
            name: doc.get('name') ?? '',
            role: doc.get('strength') ?? '0'

        );

      }).toList();

    }

    //userData from snapshot
    UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
      return UserData(
          uid: uid,
          name: snapshot.get('name'),
          role: snapshot.get('role'));
    }

    //get users stream
  Stream<List<AllUsers>>get users{
      return userCollection.snapshots().map(_refugeeListFromSnapshot);
  }


  //get user doc stream
  Stream<UserData> get userData{
      return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}