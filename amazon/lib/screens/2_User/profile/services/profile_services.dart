import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart' as http;

class ProfileServices {
  Future<List<Order>> getOrderDetails({
    required BuildContext context,
  }) async {
    final userProider = Provider.of<UserProider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/order-detail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProider.user.token,
        },
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              orderList.add(
                Order.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

//logout
  void logout({required BuildContext context}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      //just making this token empty
      await sharedPreferences.setString("auth-token", '');
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
