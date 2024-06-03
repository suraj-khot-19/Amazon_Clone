import 'package:amazon/utils/exports.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    //AuthScreen()
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    //MyHomeScreen()
    case MyHomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyHomeScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Page Not Found!"),
          ),
        ),
      );
  }
}
