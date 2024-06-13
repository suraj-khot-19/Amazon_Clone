import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  //rating fun
  void rateProduct({
    required BuildContext context,
    required double rating,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/rate-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
        body: jsonEncode({
          "id": product.id!,
          "rating": rating,
        }),
      );
      httpErrorHandling(response: response, onSuccess: () {}, context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //add to cart
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/add-to-cart"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
        body: jsonEncode({
          "id": product.id!,
        }),
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              cart: jsonDecode(response.body)['cart'],
            );
            userProvider.setUserFromMode(user);
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
