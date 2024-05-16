import 'package:flutter/foundation.dart' show immutable;
import 'package:practice_flutter/core/constants/firebase_field_names.dart';

@immutable class UserModel {
  final String fullName;
  final DateTime birthday;
  final String gender;
  final String email;
  final String password;
  final String profilePicUrl;
  final String uid;
  final List<String> friends;
  final List<String> sentRequests;
  final List<String> receivedRequests;

  const UserModel({
    required this.birthday,
    required this.fullName,
    required this.gender,
    required this.email,
    required this.password,
    this.profilePicUrl = '',
    required this.uid,
    required this.friends,
    required this.sentRequests,
    required this.receivedRequests
  });

  // about converting a model to an object.
  // this is going to return the map version of the model
  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      FirebaseFieldNames.fullName: fullName,
      FirebaseFieldNames.birthday: birthday.millisecondsSinceEpoch,
      FirebaseFieldNames.gender: gender,
      FirebaseFieldNames.email: email,
      FirebaseFieldNames.password: password,
      FirebaseFieldNames.profilePicUrl: profilePicUrl,
      FirebaseFieldNames.uid: uid,
      FirebaseFieldNames.friends: friends,
      FirebaseFieldNames.sentRequests: sentRequests,
      FirebaseFieldNames.receivedRequests: receivedRequests,
    };
  }

  // i think part has to do with taking data in the form of an object and converting to a model of type User.
  // this has to do with creating a new model of type user.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map[FirebaseFieldNames.fullName] as String,
      birthday: DateTime.fromMillisecondsSinceEpoch(map[FirebaseFieldNames.birthday] as int),
      gender: map[FirebaseFieldNames.gender] as String,
      email: map[FirebaseFieldNames.email] as String,
      password: map[FirebaseFieldNames.password] as String,
      profilePicUrl: map[FirebaseFieldNames.profilePicUrl] as String,
      uid: map[FirebaseFieldNames.uid] as String,
      friends: List<String>.from((map[FirebaseFieldNames.friends] ?? [ ])),
      sentRequests: List<String>.from((map[FirebaseFieldNames.sentRequests] ?? [])),
      receivedRequests: List<String>.from((map[FirebaseFieldNames.receivedRequests] ?? [])),
    );
  }
}

