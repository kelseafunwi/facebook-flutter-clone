import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/auth/models/user.dart';

// autoDispose is used to clear the listener when we are done with it and is used in combination with the
// StreamProvider and the FutureProvider.
final getUserInfoAsStreamProvider = StreamProvider.autoDispose<UserModel>((ref) {
  final controller = StreamController<UserModel>();

  final sub = FirebaseFirestore.instance
    .collection(FirebaseCollectionNames.users)
    .where(FirebaseFieldNames.uid, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .limit(1)
    .snapshots()
    .listen((snapshot) {
      final userData = snapshot.docs.first;
      final user = UserModel.fromMap(userData.data());
      controller.sink.add(user);
  });
  
  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});