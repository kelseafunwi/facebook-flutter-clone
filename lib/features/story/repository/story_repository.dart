import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_collection_names.dart';
import 'package:practice_flutter/core/constants/firebase_field_names.dart';
import 'package:practice_flutter/core/constants/storage_folder_names.dart';
import 'package:practice_flutter/features/story/models/story.dart';
import 'package:uuid/uuid.dart';

@immutable
class StoryRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _myUid = FirebaseAuth.instance.currentUser!.uid;

  // the story repository is used for putting or changing data which is in the cloud
  // while the providers is used for fetching the data that has been put online.

  Future<String?> postStory({
    required File image,
  }) async {
    try {
      // the image will be uploaded under the particular story id.
      final storyId = const Uuid().v1();
      final now = DateTime.now();
      Reference path = _storage.ref(StorageFolderNames.stories).child(storyId);
      TaskSnapshot taskSnapshot = await path.putFile(image);
      // the download url is gotten from the snapshot.
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // created the story element
      Story story = Story(
          imageUrl: downloadUrl,
          createdAt: now,
          storyId: storyId,
          authorId: _myUid,
          views: const []);

      // doc and set is used to set particular fields in firebase to certain values.
      await _firestore
          .collection(FirebaseCollectionNames.stories)
          .doc(storyId)
          .set(story.toMap());

      return null;
    } catch (error) {
      return error.toString();
    }
  }

  // adding my uid to the list of the people who have viewed the story
  Future<String?> viewStory({required String storyId}) async {
    try {
      //adding my uid to the list of people that have viewed that particular story.
      await _firestore
          .collection(FirebaseCollectionNames.stories)
          .doc(storyId)
          .update({
        FirebaseFieldNames.views: FieldValue.arrayRemove([_myUid])
      });

      return null;
    } catch (error) {
      return error.toString();
    }
  }
}
