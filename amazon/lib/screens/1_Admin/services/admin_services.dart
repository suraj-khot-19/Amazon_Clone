import '../../../utils/exports.dart';
import 'package:http/http.dart' as http;

class AdminServices {
  //add producct function
  Future<void> sellProduct({
    required BuildContext context,
    required String productName,
    required String description,
    required String category,
    required double quantity,
    required double price,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    try {
      //using cloudinary to store imgaes
      final cloudinary = CloudinaryPublic("dg9rfqe0v", "z1puondu");
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        //adding file with folder name as productName
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: productName),
        );
        //adding only url not files
        imageUrl.add(response.secureUrl);
      }
      //upload urls to mongodb using model Product
      Product product = Product(
          name: productName,
          description: description,
          quantity: quantity,
          images: imageUrl,
          category: category,
          price: price);
      http.Response response = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            showSnackBar(context, "Product added successfully!");
            Navigator.pop(context);
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //fetch product
  //add producct function
  Future<List<Product>> getProduct(BuildContext context) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http
          .get(Uri.parse("$uri/admin/get-product"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "auth-token": userProvider.user.token,
      });
      httpErrorHandling(
        response: response,
        context: context,
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
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }

  //delete product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback runToDelete,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse(
          '$uri/admin/delete-product',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
        body: jsonEncode(
            //passing is to delete it
            {'id': product.id}),
      );
      httpErrorHandling(
          response: response, onSuccess: runToDelete, context: context);
    } catch (e) {
      return showSnackBar(context, e.toString());
    }
  }

  //to see order details
  Future<List<Order>> getOrderDetails({
    required BuildContext context,
  }) async {
    List<Order> orderList = [];
    final userProvider = Provider.of<UserProider>(context, listen: false);
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/admin/order-detail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
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

  //services to change status

  //to see order details
  void changeStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/admin/order-status"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );
      httpErrorHandling(
          response: response, onSuccess: onSuccess, context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//analytics
  Future<Map<String, dynamic>> viewAnalytics({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/admin/analytics"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": userProvider.user.token,
        },
      );
      httpErrorHandling(
          response: response,
          onSuccess: () {
            var res = jsonDecode(response.body);

            totalEarning = res['totalEarnings'];
            sales = [
              Sales("Mobile", res['mobileEarnigs']),
              Sales("Fresh", res['freshEarnigs']),
              Sales("Fashion", res['fashionEarnigs']),
              Sales("Electronics", res['electronicsEarnigs']),
              Sales("Home", res['homeEarnigs']),
              Sales("Deals", res['dealsEarnigs']),
              Sales("Beauty", res['beautyEarnigs']),
              Sales("Appliances", res['appliancesEarnigs']),
              Sales("Book", res['booksEarnigs']),
              Sales("Everyday", res['everydayEarnigs']),
            ];
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalErnings': totalEarning,
    };
  }
}
