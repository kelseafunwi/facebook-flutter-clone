import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/features/auth/models/user.dart';

final getUserInfoProvider = FutureProvider.autoDispose<UserModel>((ref) {
  return FirebaseFirestore.instance.collection(FirebaseCollectionNames.users)
      .doc(FirebaseAuth.instance.currentUser!.uid).get()
      .then((userData) {
        // the ! put at the end is used to indicate that the result of this can be a null.
        // i think from this i can conclude that it is possible for me to pass in a null to the UserModel types fromMap function
        return UserModel.fromMap(userData.data()!);
      });
});