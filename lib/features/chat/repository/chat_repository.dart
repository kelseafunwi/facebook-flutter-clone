import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/chat/models/chatroom.dart';
import 'package:practice_flutter/features/chat/models/message.dart';
import 'package:uuid/uuid.dart';

@immutable
class ChatRepository {
  final _myUid = FirebaseAuth.instance.currentUser!.uid;
  final _storage = FirebaseStorage.instance;

  Future<String?> createChatroom({
    required String userId,
  }) async {
    try {
      CollectionReference chatrooms = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms);

      // a chat rooms comes between me and another user from their userId
      final sortedMembers = [_myUid, userId]
        ..sort((a, b) => a.compareTo(b)); // returns 0 for equal,

      QuerySnapshot existingChatrooms = await chatrooms
          .where(FirebaseFieldNames.members, isEqualTo: sortedMembers)
          .get();

      if (existingChatrooms.docs.isNotEmpty) {
        return existingChatrooms.docs.first.id;
      } else {
        // generate the random Id.
        final chatroomId = const Uuid().v4();

        final now = DateTime.now();

        ChatRoom chatRoom = ChatRoom(chatroomId, '', now, sortedMembers, now);

        await FirebaseFirestore.instance
            .collection(FirebaseCollectionNames.chatrooms)
            .doc(chatroomId)
            .set(chatRoom.toMap());

        return chatroomId;
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> sendMessage({required String message,
    required String chatroomId,
    required String receiverId}) async {
    try {
      // generate the unique message id
      final messageId = const Uuid().v4();
      final now = DateTime.now();

      Message newMessage =
      Message(
          message,
          messageId,
          _myUid,
          receiverId,
          now,
          false,
          'text');

      DocumentReference myChatRef = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms)
          .doc(chatroomId);

      await myChatRef.collection(FirebaseCollectionNames.messages).doc(
          messageId).set(newMessage.toMap());

      await myChatRef.collection(FirebaseCollectionNames.messages).doc(
          messageId).set(newMessage.toMap());

      await myChatRef.update({
        FirebaseFieldNames.lastMessage: message,
        FirebaseFieldNames.lastMessageTs: now.millisecondsSinceEpoch
      });

      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> sendFileMessage({required File file,
    required String chatroomId,
    required String receiverId,
    required String messageType,
  }) async {
    try {
      // generate the unique message id
      final messageId = const Uuid().v4();
      final now = DateTime.now();

      // save to storage
      // creating the reference where we are goig to store the message.

      Reference ref = _storage.ref(messageType).child(messageId);
      // initiate the transfer of the file.
      TaskSnapshot snapshot = await ref.putFile(file);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      Message newMessage =
      Message(
          downloadUrl,
          messageId,
          _myUid,
          receiverId,
          now,
          false,
          messageType);

      DocumentReference myChatRef = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms)
          .doc(chatroomId);

      await myChatRef.collection(FirebaseCollectionNames.messages).doc(
          messageId).set(newMessage.toMap());

      await myChatRef.collection(FirebaseCollectionNames.messages).doc(
          messageId).set(newMessage.toMap());

      await myChatRef.update({
        FirebaseFieldNames.lastMessage: "sent an $messageType",
        FirebaseFieldNames.lastMessageTs: now.millisecondsSinceEpoch
      });

      return null;
    } catch (error) {
      return error.toString();
    }
  }


  Future<String?> seenMessages(
      {required String chatroomId, required String messageId}) async {
    try {
      await FirebaseFirestore.instance.collection(
          FirebaseCollectionNames.chatrooms).doc(chatroomId).collection(
          FirebaseCollectionNames.messages).doc(messageId).update({FirebaseFieldNames.seen: true});

      return null;
    } catch (error) {
      return error.toString();
    }
  }

}
