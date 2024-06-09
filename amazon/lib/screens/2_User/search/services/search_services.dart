import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchProductWithSearch({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    List<Product> productListWithSearchMatch = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/search/$searchQuery"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productListWithSearchMatch.add(
                Product.fromJson(
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
    return productListWithSearchMatch;
  }
}
