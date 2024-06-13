import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart' as http;

class CartService {
  //remove from cart
  void removeProductFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse("$uri/api/delete-from-cart/${product.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
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
