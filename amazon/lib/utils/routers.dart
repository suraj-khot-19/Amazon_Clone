import 'package:amazon/screens/2_User/profile/screens/your_orders.dart';
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
    //SearchScreen
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          search: searchQuery,
        ),
      );
    //Product Desciption
    case ProductDescription.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDescription(
          product: product,
        ),
      );
    //Address Screen
    case AddressScreen.routeName:
      var amt = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmt: amt,
        ),
      );
    //OrderDetails Screen
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(
                order: order,
              ));
    //user order screen
    case YourOrders.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => YourOrders(),
      );
    //cart screen
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CartScreen(),
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
