import 'package:flutter/cupertino.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/first_screen.dart';
import 'package:practice_flutter/core/screens/home_screen.dart';
import 'package:practice_flutter/core/screens/profile_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/create_account_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:practice_flutter/features/friends/presentation/screens/friends_screen.dart';
import 'package:practice_flutter/features/posts/presentation/screens/comments_screen.dart';
import 'package:practice_flutter/features/posts/presentation/screens/create_post_screen.dart';
import 'package:practice_flutter/features/posts/presentation/screens/post_screen.dart';
import 'package:practice_flutter/features/story/models/story.dart';
import 'package:practice_flutter/features/story/presentation/screens/create_story_screen.dart';
import 'package:practice_flutter/features/story/presentation/screens/story_view_screen.dart';
import 'package:practice_flutter/widgets/splash_screen.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case CreateAccountScreen.routeName:
        return _cupertinoRoute(
          const CreateAccountScreen(),
        );
      case HomeScreen.routeName:
        return _cupertinoRoute(
          const HomeScreen()
        );
      case CreatePostScreen.routeName:
        return _cupertinoRoute(
            const CreatePostScreen()
        );
      case ForgotPasswordScreen.routeName:
        return _cupertinoRoute(
          const ForgotPasswordScreen()
        );
      case PostScreen.routeName:
        return _cupertinoRoute(
            const ForgotPasswordScreen()
        );

      case CommentsScreen.routeName:
        final postId = settings.arguments as String;
        return _cupertinoRoute(
            CommentsScreen(postId: postId)
        );
      case SplashScreen.routeName:
        return _cupertinoRoute(
          const SplashScreen(),
        );
      case FirstScreen.routeName:
        return _cupertinoRoute(
          const FirstScreen(),
        );

      case FriendsScreen.routeName:
        return _cupertinoRoute(
          const FriendsScreen(),
        );

      case ProfileScreen.routeName:
        final userId = settings.arguments as String;
        return _cupertinoRoute(
          ProfileScreen(
            userId: userId,
          ),
        );

      case CreateStoryScreen.routeName:
        return _cupertinoRoute(
          const CreateStoryScreen()
        );

      case StoryViewScreen.routeName:
        final stories = settings.arguments as List<Story>;
        return _cupertinoRoute(
            StoryViewScreen(stories: stories)
        );


      default:
        return _cupertinoRoute(
            ErrorScreen(error: "Wrong route provided ${settings.name}")
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
      builder: (_) => view,
  );
}

