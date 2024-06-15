import 'package:amazon/utils/exports.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final ProfileServices profileServices = ProfileServices();
  List<Order>? orders;
  @override
  void initState() {
    super.initState();
    getOrder();
  }

  void getOrder() async {
    orders = await profileServices.getOrderDetails(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? CustomProgressIndicator()
        : SizedBox(
            height: 400,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, OrderDetailsScreen.routeName,
                      arguments: orders![index]),
                  child: orders![index].status >= 3
                      ? SizedBox()
                      : Column(
                          children: [
                            SingleOrder(
                              img: orders![index].products[0].images[0],
                              isChange: true,
                              passTheText: orders![index].products[0].name,
                            ),
                          ],
                        ),
                );
              },
            ),
          );
  }
}
