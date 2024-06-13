import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart ' as http;

class AddressService {
  //saving user address
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProider = Provider.of<UserProider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/pay"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProider.user.token,
        },
        body: jsonEncode(
          {
            'address': address,
          },
        ),
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            User user = userProider.user.copyWith(
              address: jsonDecode(response.body)['address'],
            );
            userProider.setUserFromMode(user);
          },
          context: context);
    } catch (r) {
      showSnackBar(context, r.toString());
    }
  }

  //order
  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProider = Provider.of<UserProider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/order"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProider.user.token,
        },
        body: jsonEncode(
          {
            'cart': userProider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          },
        ),
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            showSnackBar(context, "Your order has been placed!");
            User user = userProider.user.copyWith(
              cart: [],
            );
            userProider.setUserFromMode(user);
          },
          context: context);
    } catch (r) {
      showSnackBar(context, r.toString());
    }
  }
}
