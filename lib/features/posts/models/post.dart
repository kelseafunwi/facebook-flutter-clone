import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_field_names.dart';

@immutable
class Post {
  final String postId;
  final String posterId;
  final String content;
  final String postType;
  final String fileUrl;
  final DateTime createdAt;
  final List<String> likes;

  // the developer will use this as the model in order to create a new element
  const Post({
    required this.postId,
    required this.posterId,
    required this.content,
    required this.postType,
    required this.fileUrl,
    required this.createdAt,
    required this.likes,
  });

  // when the user wants to convert a post to a map this is the function that we are going to use
  Map<String, dynamic> toMap() => {
    FirebaseFieldNames.postId: postId,
    FirebaseFieldNames.posterId: posterId,
    FirebaseFieldNames.content: content,
    FirebaseFieldNames.postType: postType,
    FirebaseFieldNames.fileUrl: fileUrl,
    FirebaseFieldNames.datePublished: createdAt.millisecondsSinceEpoch,
    FirebaseFieldNames.likes: likes,
  };

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map[FirebaseFieldNames.postId] ?? '',
      posterId: map[FirebaseFieldNames.posterId] ?? '',
      content: map[FirebaseFieldNames.content] ?? '',
      postType: map[FirebaseFieldNames.postType] ?? '',
      fileUrl: map[FirebaseFieldNames.fileUrl] ?? '',
      createdAt: DateTime.fromMicrosecondsSinceEpoch(map[FirebaseFieldNames.datePublished] ?? 0),
      likes: List<String>.from(map[FirebaseFieldNames.likes] ?? []) ,
    );
  }

}