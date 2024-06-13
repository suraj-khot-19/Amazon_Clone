import 'package:amazon/screens/2_User/cart/cart_services.dart';
import 'package:amazon/utils/exports.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  //add to cart
  ProductServices productServices = ProductServices();
  void callForAdd(Product product) {
    productServices.addToCart(context: context, product: product);
  }

  //remove to cart insance and function
  CartService cartService = CartService();
  void callForRemove(Product product) {
    cartService.removeProductFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final cartProduct =
        Provider.of<UserProider>(context).user.cart[widget.index];
    final product = Product.fromMap(cartProduct['product']);
    final quantity = cartProduct['quantity'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  //image
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Image.network(
                      product.images[0],
                      height: 130,
                      width: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                  //increase decrease
                  Container(
                    padding: EdgeInsets.all(1),
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.black12),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //calling function to remove
                        InkWell(
                            onTap: () => callForRemove(product),
                            child: Icon(Icons.remove)),
                        Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              quantity.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),

                        //calling function to add to cart
                        InkWell(
                            onTap: () => callForAdd(product),
                            child: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ],
              ),
              //short discription
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 12.0, bottom: 12.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\₹ ${product.price}",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(
                            Icons.check,
                            color: AppStyles.secondaryColor,
                            size: 20,
                          ),
                          Text(
                            "prime",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppStyles.secondaryColor),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.red,
                        width: 135,
                        height: 20,
                        child: Center(
                          child: Text(
                            "Limited Time Deal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Text(
                        "In Stock",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppStyles.selectedNavBarColor),
                      ),
                      Text("Get it on Friday Aug 19"),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 5,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
