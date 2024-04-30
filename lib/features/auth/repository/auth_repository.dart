import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/storage_folder_names.dart';
import 'package:practice_flutter/features/auth/models/user.dart';
import 'package:practice_flutter/utils/utils.dart';

class AuthRepository {
  // creating an instance of firebase auth
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signIn({
    required String email,
    required String password
  }) async {
    try {
      final credential = _auth.signInWithEmailAndPassword(email: email, password: password);

      return credential;
    } catch (e) {
      showToastMessage(e: e.toString());
      return null;
    }
  }

  // the signout function returns a string to the user
  Future<String?> signOut() async {
    try {
      _auth.signOut();
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  // creating the account
  Future<UserCredential?> createAccount({
    required String fullName,
    required DateTime birthday,
    required String password,
    required String email,
    required String gender,
    // the image we are getting can be optional,
    required File? image,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // getting the specific id address where this user is going to put their app
      final path = _storage.ref(StorageFolderNames.profilePics).child(_auth.currentUser!.uid);

      if (image == null) {
        return null;
      }

      final taskSnapshot = await path.putFile(image);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // creating a new user model from the information we received.
      UserModel userModel = UserModel(
        birthday: birthday,
        fullName: fullName,
        gender: gender,
        email: email,
        password: password,
        profilePicUrl: downloadUrl,
        uid: _auth.currentUser!.uid,
        friends: const [],
        sentRequests: const [],
        receivedRequests: const []
      );

      // we can use the set method on particular doc.
      await _firestore.collection(FirebaseCollectionNames.users).doc(_auth.currentUser!.uid).set(userModel.toMap());
      return credential;
    } catch (error) {
      showToastMessage(e: error.toString());
      return null;
    }
  }

  // this is going to to send the user the email verification link
  Future<String?> verifyEmail() async{
    try {
      final user = _auth.currentUser;
      if (user != null) {
        user.sendEmailVerification();
      }
      return null;
    } catch (error) {
      showToastMessage(e: error.toString());
      return error.toString();
    }
  }

  // get the information about the user
  Future<UserModel?> getUserInfo() async {
    try {
      final userData = await _firestore.collection(FirebaseCollectionNames.users).doc(_auth.currentUser!.uid).get();
      return UserModel.fromMap(userData.data()!);
    } catch (error) {
      showToastMessage(e: error.toString());
      return null;
    }
  }

}