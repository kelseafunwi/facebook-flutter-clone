import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/auth/models/user.dart';
import 'package:practice_flutter/features/friends/providers/friends_provider.dart';
import 'package:practice_flutter/widgets/round_button.dart';

class AddFriendButton extends ConsumerStatefulWidget {
  final UserModel user;

  const AddFriendButton({super.key, required this.user});

  @override
  ConsumerState<AddFriendButton> createState() => _AddFriendButtonState();
}

class _AddFriendButtonState extends ConsumerState<AddFriendButton> {
  @override
  Widget build(BuildContext context) {

    bool isLoading = false;

    // can only add a user if they have sentRequest to me or received a request from me
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    // checks if that user received a request from me
    final requestSent = widget.user.receivedRequests.contains(myUid);

    // checks if the user received the request.
    final requestReceived = widget.user.sentRequests.contains(myUid);

    // checks if we are already friends
    final alreadyFriends = widget.user.friends.contains(myUid);

    return isLoading
        ? const Loader()
        : RoundButton(
      // nothing will be done if the request had already been sent.
        onPressed: requestReceived ?
        null: () async {
          setState(() {
            isLoading = true;
          });

          // holding the provider information for the friends
          // the provider contains the method we've been building to handle things related to the friends
          final provider = ref.read(friendProvider);

          final userId = widget.user.uid;

          if (requestSent) {
            // cancel the request ie the other user received a request from me
            await provider.removeFriendRequest(userId: userId);

          } else if (alreadyFriends) {
            // remove the friendship
            await provider.removeFriend(userId: userId);

          } else {

            await provider.sendFriendRequest(userId: userId);

          }

          setState(() {
            isLoading = false;
          });
        },
        label: requestSent ?
            "Cancel Request" :
            alreadyFriends ?
            "Remove Friend" :
            "Add Friend",
    );
  }
}
