import 'package:flutter/cupertino.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/create_account_screen.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case CreateAccountScreen.routeName:
        return _cupertinoRoute(
          const CreateAccountScreen(),
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

