import 'package:amazon/utils/exports.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    List list = [
      "https://images-eu.ssl-images-amazon.com/images/I/71eUwDk8z+L._AC_UL450_SR450,320_.jpg",
      "https://images-eu.ssl-images-amazon.com/images/I/71eUwDk8z+L._AC_UL450_SR450,320_.jpg",
      "https://images-eu.ssl-images-amazon.com/images/I/71eUwDk8z+L._AC_UL450_SR450,320_.jpg",
      "https://images-eu.ssl-images-amazon.com/images/I/71eUwDk8z+L._AC_UL450_SR450,320_.jpg",
      "https://images-eu.ssl-images-amazon.com/images/I/71eUwDk8z+L._AC_UL450_SR450,320_.jpg",
    ];
    return SizedBox(
      height: 180,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return SingleOrder(img: list[index]);
        },
      ),
    );
  }
}
