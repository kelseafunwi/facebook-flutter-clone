import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/posts/models/post.dart';

final getAllPostProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {

  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
    .collection(FirebaseCollectionNames.posts)
    .orderBy(FirebaseFieldNames.datePublished, descending: true)
    .snapshots()
    .listen((snapshot) {
      if (kDebugMode) {
        print("Snapshot received");
      }
      final posts = snapshot.docs.map(
        (postData) => Post.fromMap(postData.data())
      );
      controller.sink.add(posts);
    });
  
  ref.onDispose(() {
    if (kDebugMode) {
      print("Disposing the method wich gets all the post from firebase");
    }
    sub.cancel(); // cancel subscription
    controller.close(); // close controller
  });

  return controller.stream;
});
