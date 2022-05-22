// import 'dart:html';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
//
// import 'chat.dart';
//
// class ChatProvider extends StatefulWidget {
//   const ChatProvider({Key? key}) : super(key: key);
//
//   @override
//   State<ChatProvider> createState() => _ChatProviderState();
// }
//
// class _ChatProviderState extends State<ChatProvider> {
//
//   Future<void> updateFirestoreData(
//       String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
//     return FirebaseFirestore.instance
//         .collection(collectionPath)
//         .doc(docPath)
//         .update(dataUpdate);
//   }
//
//   Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
//     return FirebaseFirestore.instance
//         .collection("pathMessageCollection")
//         .doc(groupChatId)
//         .collection(groupChatId)
//         .orderBy("time", descending: true)
//         .limit(limit)
//         .snapshots();
//   }
//
//   void sendChatMessage(String content, int type, String groupChatId,
//       String currentUserId, String peerId) {
//     DocumentReference documentReference = FirebaseFirestore.instance
//         .collection("pathMessageCollection")
//         .doc(groupChatId)
//         .collection(groupChatId)
//         .doc(DateTime.now().millisecondsSinceEpoch.toString());
//     ChatMessages chatMessages = ChatMessages(
//         idFrom: currentUserId,
//         idTo: peerId,
//         timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
//         content: content,
//         type: type);
//
//     FirebaseFirestore.instance.runTransaction((transaction) async {
//       transaction.set(documentReference, chatMessages.toJson());
//     });
//   }
//
//   // checking if sent message
//   bool isMessageSent(int index) {
//     if ((index > 0 &&
//         listMessages[index - 1].get(FirestoreConstants.idFrom) !=
//             currentUserId) ||  index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
