import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart' as http;

class DealOfDayServices {
  Future<Product> dealOfTheDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    Product productList = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0);
    try {
      //geting product with deal of day>>ratings
      http.Response response = await http.get(
        Uri.parse("$uri/api/deal-of-day"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            productList = Product.fromJson(response.body);
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
