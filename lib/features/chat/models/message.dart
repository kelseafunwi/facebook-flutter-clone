import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_field_names.dart';

@immutable class Message {

  final String message;
  final String messageId;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;
  final bool seen;
  final String messageType;

  const Message(this.message, this.messageId, this.senderId, this.receiverId,
      this.timestamp, this.seen, this.messageType);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      FirebaseFieldNames.message: message,
      FirebaseFieldNames.messageId: messageId,
      FirebaseFieldNames.senderId: senderId,
      FirebaseFieldNames.receiverId: receiverId,
      FirebaseFieldNames.timestamp: timestamp.millisecondsSinceEpoch,
      FirebaseFieldNames.seen: seen,
      FirebaseFieldNames.messageType: messageType,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      map[FirebaseFieldNames.message] as String,
      map[FirebaseFieldNames.messageId] as String,
      map[FirebaseFieldNames.senderId] as String,
      map[FirebaseFieldNames.receiverId] as String,
      DateTime.fromMicrosecondsSinceEpoch(map[FirebaseFieldNames.timestamp] as int),
      map[FirebaseFieldNames.seen] as bool,
      map[FirebaseFieldNames.messageType] as String,
    );
  }

}