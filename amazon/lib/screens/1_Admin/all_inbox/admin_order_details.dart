import 'package:amazon/utils/exports.dart';

class AdminOrderDetails extends StatefulWidget {
  const AdminOrderDetails({super.key});

  @override
  State<AdminOrderDetails> createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  final AdminServices adminServices = AdminServices();
  List<Order>? order;
  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    order = await adminServices.getOrderDetails(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return order == null
        ? CustomProgressIndicator()
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your All Orders",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: order!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, OrderDetailsScreen.routeName,
                            arguments: order![index]),
                        child: SizedBox(
                          height: 150,
                          child: SingleOrder(
                            img: order![index].products[0].images[0],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
