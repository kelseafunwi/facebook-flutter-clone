import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/features/posts/models/comment.dart';
import 'package:practice_flutter/features/posts/models/post.dart';
import 'package:practice_flutter/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

@immutable
class PostRepository {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String?> makePost({
    required String content,
    required File file,
    required String postType,
  }) async {
    try {
      final postId = const Uuid().v1();
      final posterId = _auth.currentUser!.uid;
      final now = DateTime.now();

      final fileUuid = const Uuid().v1();
      final path = _storage.ref(postType).child(fileUuid);
      final taskSnapshot = await path.putFile(file);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      Post post = Post(
          postId: postId,
          posterId: posterId,
          content: content,
          postType: postType,
          fileUrl: downloadUrl,
          datePublished: now,
          likes: const [],
      );

      _firestore
          .collection(FirebaseCollectionNames.posts)
          .doc(postId)
          .set(post.toMap());

      return null;
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

      if (likes.contains(authorId)) {
        _firestore
          .collection(FirebaseCollectionNames.posts)
          .doc(postId)
          .update({
            FirebaseFieldNames.likes: FieldValue.arrayRemove([authorId])
          });
      } else {
        _firestore
            .collection(FirebaseCollectionNames.posts)
            .doc(postId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayUnion([authorId])
        });
      }

    } catch (error) {
      if (kDebugMode) {
        print("Error occured in post_repository provider class");
      }
      showToastMessage(e: error.toString());
      return error.toString();
    }
    return null;
  }

  Future<String?> makeComment({
    required String text,
    required String postId,
  }) async {
    try {
      final commentId = const Uuid().v1();
      final posterId = _auth.currentUser!.uid;
      final now = DateTime.now();

      Comment comment = Comment(commentId: commentId, authorId: posterId, postId: postId, text: text, createdAt: now, likes: const []);

      _firestore
        .collection(FirebaseCollectionNames.comments)
        .doc(commentId)
        .set(comment.toMap());

      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> likeOrDislikeComment({
    required String commentId,
    required List<String> likes,
  }) async {

    try {
      final authorId = _auth.currentUser!.uid;

      if (likes.contains(authorId)) {
        _firestore
            .collection(FirebaseCollectionNames.comments)
            .doc(commentId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayRemove([authorId])
        });
      } else {
        _firestore
            .collection(FirebaseCollectionNames.comments)
            .doc(commentId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayUnion([authorId])
        });
      }

    } catch (error) {
      if (kDebugMode) {
        print("Error occured in post_repository provider class");
      }
      showToastMessage(e: error.toString());
      return error.toString();
    }
    return null;
  }

}