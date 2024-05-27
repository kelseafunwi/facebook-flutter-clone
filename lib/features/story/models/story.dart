import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_field_names.dart';

@immutable class Story {

  final String imageUrl;
  final DateTime createdAt;
  final String storyId;
  final String authorId;
  final List<String> views;

  const Story({
    required this.imageUrl,
    required this.createdAt,
    required this.storyId,
    required this.authorId,
    required this.views
  });

  Story copyWith({
    String? imageUrl,
    DateTime? createdAt,
    String? storyId,
    String? authorId,
    List<String>? views
  }) {
    return Story(
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      storyId: storyId ?? this.storyId,
      authorId: authorId ?? this.authorId,
      views: views ?? this.views
    );
  }

  @override
  String toString() {
    return 'Story(imageUrl: $imageUrl, createdAt: $createdAt, storyId: $storyId, authorId: $authorId, views: $views)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.imageUrl: imageUrl,
      FirebaseFieldNames.createdAt: createdAt.millisecondsSinceEpoch,
      FirebaseFieldNames.storyId: storyId,
      FirebaseFieldNames.authorId: authorId,
      FirebaseFieldNames.views: views
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      imageUrl: map[FirebaseFieldNames.imageUrl] as String,
      // when converting into a Story then we pass the real DateTime object.
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[FirebaseFieldNames.createdAt] as int),
      storyId: map[FirebaseFieldNames.storyId] as String,
      authorId: map[FirebaseFieldNames.authorId] as String,
      views: map[FirebaseFieldNames.views] as List<String>
    );
  }

}