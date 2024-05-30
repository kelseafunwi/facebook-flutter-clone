// getting all the chat rooms that we are part of and we also getting this data in real time
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/chat/models/chatroom.dart';

final getAllChatsProvider = StreamProvider.autoDispose<Iterable<ChatRoom>>((ref) {

  final controller = StreamController<Iterable<ChatRoom>>();

  final myUid = FirebaseAuth.instance.currentUser!.uid;

  final sub = FirebaseFirestore.instance.collection(
      FirebaseCollectionNames.chatrooms).where(
      FirebaseFieldNames.members, arrayContains: myUid).orderBy(
      FirebaseFieldNames.lastMessageTs).snapshots().listen((snapshot) {
        final chats = snapshot.docs.map((chatData) {
          return ChatRoom.fromMap(chatData.data());
        });
        controller.sink.add(chats);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });


  return controller.stream;
});