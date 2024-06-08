import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart' as http;

class ProductCategorySevice {
  Future<List<Product>> getProductWithCategory({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    List<Product> productList = [];
    try {
      //geting product with category
      http.Response response = await http.get(
        Uri.parse("$uri/api/category-product?category=$category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
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
    return productList;
  }
}
