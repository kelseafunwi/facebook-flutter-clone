// getting all the chat rooms that we are part of and we also getting this data in real time
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/chat/models/message.dart';

final getAllChatsProvider =
StreamProvider.autoDispose.family<Iterable<Message>, String>((ref, String chatroomId) {

  final controller = StreamController<Iterable<Message>>();

  final myUid = FirebaseAuth.instance.currentUser!.uid;

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.chatrooms)
      .doc(chatroomId)
      .collection(FirebaseCollectionNames.messages)
      .where(FirebaseFieldNames.members, arrayContains: myUid)
      .orderBy(FirebaseFieldNames.lastMessageTs)
      .snapshots()
      .listen((snapshot) {
    final messages = snapshot.docs.map((messageData) {
      return Message.fromMap(messageData.data());
    });
    controller.sink.add(messages);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
