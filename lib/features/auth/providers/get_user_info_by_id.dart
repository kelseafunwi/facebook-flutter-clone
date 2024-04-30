import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';

import '../models/user.dart';

// the types in the generic indicate the types that the parameters are going to be having.
final getUserInfoByIdProvider = FutureProvider.autoDispose.family<UserModel, String>((ref, uid){
  return FirebaseFirestore.instance.collection(FirebaseCollectionNames.users).doc(uid).get().then((userData) {
    return UserModel.fromMap(userData.data()!);
  });
});