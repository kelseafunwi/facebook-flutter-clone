import 'package:flutter/cupertino.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/home_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/create_account_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/forgot_password_screen.dart';

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
      case ForgotPasswordScreen.routeName:
        return _cupertinoRoute(
          const ForgotPasswordScreen()
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

