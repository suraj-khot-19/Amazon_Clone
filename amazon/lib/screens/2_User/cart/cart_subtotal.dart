import 'package:amazon/utils/exports.dart';

class CartSubTotal extends StatelessWidget {
  const CartSubTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProider>(context).user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            "Subtotal : ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            sum.toString() + " ₹",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
