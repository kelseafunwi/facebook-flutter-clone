import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/posts/models/comment.dart';

final getAllCommentsProvider = StreamProvider.autoDispose<Iterable<Comment>>((ref) {

  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
    .collection(FirebaseCollectionNames.comments)
    .orderBy(FirebaseFieldNames.createdAt, descending: true)
    .snapshots()
    .listen((snapshot) {
      if (kDebugMode) {
        print("Snapshot received");
      }
      final comments = snapshot.docs.map(
              (commentData) => Comment.fromMap(commentData.data())
      );
      controller.sink.add(comments);
    }
  );

  ref.onDispose(() {
    if (kDebugMode) {
      print("Disposing the method wich gets all the post from firebase");
    }
    sub.cancel(); // cancel subscription
    controller.close(); // close controller
  });

  return controller.stream;
});
