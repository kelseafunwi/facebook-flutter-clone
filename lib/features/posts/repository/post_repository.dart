import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/posts/models/post.dart';
import 'package:practice_flutter/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show immutable;

// we are declaring the class to be immutable so that non of our functions can be tempered with.
@immutable
class PostRepository {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  // make a post
  // each post is going to contain the content , a file and a postType.
  Future<String?> makePost({
    required String content,
    required File file,
    required String postType,
  }) async {
    try {
      // generate a randomId for each of the post
      final postId = const Uuid().v1();
      final posterId = _auth.currentUser!.uid;
      final now = DateTime.now();

      // storing the post file to the storage
      final fileUuid = const Uuid().v1();
      // this is going to be the exact name of the file inside of that folder.
      // where postType means we will have 2 folders for both the video and image postType.
      final path = _storage.ref(postType).child(fileUuid);
      // this function is going to put the file on line
      final taskSnapshot = await path.putFile(file);
      // we are going to get the downloadUrl from the snapshot
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // time to work on creating the new post the user wants
      Post post = Post(
          postId: postId,
          posterId: posterId,
          content: content,
          postType: postType,
          fileUrl: downloadUrl,
          datePublished: now,
          likes: const [],
      );

      // put the post on firestore after we are done creating it
      _firestore
          .collection(FirebaseCollectionNames.posts)
          .doc(postId)
          .set(post.toMap());
      return null;
      // the make post function will return a string incase of error and null if there is no error.
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> likeOrDislikePost({
    required String postId,
    required List<String> likes,
  }) async {
    try {
      final authorId = _auth.currentUser!.uid;

      // checks if the has liked that post.
      if (likes.contains(authorId)) {
        _firestore
          .collection(FirebaseCollectionNames.posts)
          .doc(postId)
          .update({
            FirebaseFieldNames.likes: FieldValue.arrayRemove([authorId])
          });
      } else {
        // we are going to like the post
        _firestore
            .collection(FirebaseCollectionNames.posts)
            .doc(postId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayUnion([authorId])
        });
      }

    } catch (error) {
      showToastMessage(e: error.toString());
      return error.toString();
    }
    return null;
  }
}