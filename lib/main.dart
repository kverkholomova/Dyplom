
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wol_pro_1/screens/option.dart';
import 'package:wol_pro_1/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:wol_pro_1/service/local_push_notifications.dart';
import 'package:wol_pro_1/services/auth.dart';
import 'models/user.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

      // options: FirebaseOptions(
      //   apiKey: "",
      //   appId: "",
      //   messagingSenderId: "",
      //   projectId: "",
      // )
        // options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: OptionChoose(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

