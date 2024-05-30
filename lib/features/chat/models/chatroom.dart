import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_field_names.dart';

@immutable
class ChatRoom {
  final String chatroomId;
  final String lastMessage;
  final DateTime lastMessageTs;
  final List<String> members;
  final DateTime createdAt;

  const ChatRoom(this.chatroomId, this.lastMessage, this.lastMessageTs,
      this.members, this.createdAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.chatroomId: chatroomId,
      FirebaseFieldNames.lastMessage: lastMessage,
      FirebaseFieldNames.lastMessageTs: lastMessageTs.millisecondsSinceEpoch,
      FirebaseFieldNames.members: members,
      FirebaseFieldNames.createdAt: createdAt.millisecondsSinceEpoch,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
        map[FirebaseFieldNames.chatroomId] as String,
        map[FirebaseFieldNames.lastMessage] as String,
        DateTime.fromMicrosecondsSinceEpoch(
            map[FirebaseFieldNames.lastMessageTs] as int
        ),
        List<String>.from(map[FirebaseFieldNames.members] as List),
        DateTime.fromMicrosecondsSinceEpoch(map[FirebaseFieldNames.createdAt] as int));
  }
}
