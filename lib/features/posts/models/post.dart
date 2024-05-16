import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_field_names.dart';

@immutable
class Post {
  final String postId;
  final String posterId;
  final String content;
  final String postType;
  final String fileUrl;
  final DateTime datePublished;
  final List<String> likes;

  const Post({
    required this.postId,
    required this.posterId,
    required this.content,
    required this.postType,
    required this.fileUrl,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toMap() => {
    FirebaseFieldNames.postId: postId,
    FirebaseFieldNames.posterId: posterId,
    FirebaseFieldNames.content: content,
    FirebaseFieldNames.postType: postType,
    FirebaseFieldNames.fileUrl: fileUrl,
    FirebaseFieldNames.datePublished: datePublished.millisecondsSinceEpoch,
    FirebaseFieldNames.likes: likes,
  };

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map[FirebaseFieldNames.postId] ?? '',
      posterId: map[FirebaseFieldNames.posterId] ?? '',
      content: map[FirebaseFieldNames.content] ?? '',
      postType: map[FirebaseFieldNames.postType] ?? '',
      fileUrl: map[FirebaseFieldNames.fileUrl] ?? '',
      datePublished: DateTime.fromMicrosecondsSinceEpoch(map[FirebaseFieldNames.datePublished] ?? 0),
      likes: List<String>.from(map[FirebaseFieldNames.likes] ?? []) ,
    );
  }

}