import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';

@immutable
class FriendsRepository {
  final _myUid = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  // send friend request
  Future<String?> sendFriendRequest({
    required String userId,
  }) async {

    try {

      // add my uid to the person's received request
      await _firestore.collection(FirebaseCollectionNames.users)
      .doc(userId).update({
        FirebaseFieldNames.receivedRequests: FieldValue.arrayUnion([_myUid])
      });

      // add their uid to my sent Request
      // add my uid to the persons received request
      await _firestore.collection(FirebaseCollectionNames.users)
          .doc(_myUid).update({
        FirebaseFieldNames.sentRequests: FieldValue.arrayUnion([userId])
      });

      return null;
    } catch (error) {
      return error.toString();
    }
  }

  // accepting the friend request.
  // first it will mean the request was sent to me
  // ie it is found in my received request.
  Future<String?> acceptFriendRequest({
    required String uid
  }) async {
    try {
      // add myself to their friends.
      await _firestore.collection(FirebaseCollectionNames.users)
        .doc(uid).update({
          FirebaseFieldNames.friends: FieldValue.arrayUnion([_myUid])
        });

      // add the user to my friends list
      await _firestore.collection(FirebaseCollectionNames.users)
      .doc(_myUid).update({
        FirebaseFieldNames.friends: FieldValue.arrayUnion([uid])
      });

      // remove friend request
      removeFriendRequest(userId: uid);

      return null;
    } catch (error) {
      return error.toString();
    }
  }


  Future<String?> removeFriendRequest({
    required String userId
  }) async {
    try {
      // remove that request whether from the sentRequest or the receivedRequest for myself.
      await _firestore.collection(FirebaseCollectionNames.users)
      .doc(_myUid)
      .update({
        FirebaseFieldNames.receivedRequests: FieldValue.arrayRemove([userId]),
        FirebaseFieldNames.sentRequests: FieldValue.arrayRemove([userId])
      });

      // remove my id from the person sentRequest and receivedRequest
      await _firestore.collection(FirebaseCollectionNames.users)
        .doc(userId)
        .update({
        FirebaseFieldNames.sentRequests: FieldValue.arrayRemove([userId]),
        FirebaseFieldNames.receivedRequests: FieldValue.arrayRemove([userId]),
      });

      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> removeSentRequest({
    required String uid // the uid of the person we are removing the friend request with
  }) async {
    try {
      // remove the friend request from both sides
      await removeFriendRequest(userId: uid);

      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?>  removeFriend({
    required String userId
  }) async {
    try {
      // remove that user from my friend list
      await _firestore.collection(FirebaseCollectionNames.users)
          .doc(_myUid)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayRemove([userId]),
      });

      // remove me from their friend list.
      await _firestore.collection(FirebaseCollectionNames.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayRemove([userId]),
      });

      return null;
    } catch (error) {
      return error.toString();
    }
  }



}