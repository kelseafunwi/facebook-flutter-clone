import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/auth/providers/get_user_info_provider.dart';
import 'package:practice_flutter/features/story/models/story.dart';

final getAllStoriesProvider = StreamProvider.autoDispose<Iterable<Story>>((
    ref) {
  final controller = StreamController<Iterable<Story>>();
  final userData = ref.watch(getUserInfoProvider);

  userData.whenData((user) {
    // means i am fetching stories of me and my friends.
    final myFriends = {
      user.uid,
      ...user.friends
    };

    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    // return all the stories where the uid of the person that posted it is in my friends.
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.stories)
        .orderBy(FirebaseFieldNames.createdAt, descending: true)
        .where(FirebaseFieldNames.createdAt, isGreaterThan: yesterday)
    // where the person that created is in the list of my friends.
        .where(FirebaseFieldNames.authorId, whereIn: myFriends)
        .snapshots()
        .listen((snapshot) {
      final stories = snapshot.docs
          .map((doc) => Story.fromMap(doc.data()));
      controller.sink.add(stories);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

  });

  return controller.stream;
});