import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/auth/models/user.dart';

// we will import ant use the StreamProvider method from riverpod
// we will also trigger the auto dispose flag so that it should auto
// delete when we are not using it.
final getAllFriendsProvider = StreamProvider.autoDispose((ref) {
  final myUid = FirebaseAuth.instance.currentUser!.uid;

  // provide the type that our controller will iterate over
  // when initiating the controller
  // our controller is made to carry data of a particular type
  // in this case an iterable that holds different strings.
  final controller = StreamController<Iterable<String>>();

  // we will start by getting our user
  final sub = FirebaseFirestore.instance.collection(FirebaseCollectionNames.users)
    .where(FirebaseFieldNames.uid, isEqualTo: myUid)
    .limit(1)
    .snapshots()
    .listen((snapshot) {
      // give us the first item
      final userData = snapshot.docs.first;

      // provide us with the user information
      final user = UserModel.fromMap(userData.data());
      final friends = user.friends;
      controller.sink.add(friends);
    });

  // now we need to write code to dispose things when we no longer use this provider
  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  // just like dart, dart is built to tak ein anonymous functions too.

  return controller.stream;
});