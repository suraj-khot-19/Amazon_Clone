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
    //BottomNavigation()
    case BottomNavigation.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavigation(),
      );
    //adminAddProduct
    case AdminAddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminAddProduct(),
      );
    //specific category
    case SpecificCategory.routeName:
      var categoryArgument = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SpecificCategory(
          Category: categoryArgument,
        ),
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
