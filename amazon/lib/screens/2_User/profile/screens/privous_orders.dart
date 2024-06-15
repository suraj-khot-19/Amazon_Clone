import 'package:amazon/utils/exports.dart';

class PrivousOrders extends StatefulWidget {
  static const String routeName = "/privous";
  const PrivousOrders({super.key});

  @override
  State<PrivousOrders> createState() => _PrivousOrdersState();
}

class _PrivousOrdersState extends State<PrivousOrders> {
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppStyles.appBarGradient,
            ),
            width: double.infinity,
          ),
          title: const AppBarSearch(),
        ),
      ),
      body: orders == null
          ? CustomProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSpacer(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "You Privious Orders..\nKeep Shoping...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomSpacer(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.vertical,
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          return orders![index].status >= 3
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  margin: EdgeInsets.only(bottom: 30),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black)),
                                        height: 300,
                                        child: Center(
                                          child: Image.network(orders![index]
                                              .products[0]
                                              .images[0]),
                                        ),
                                      ),
                                      CustomSpacer(
                                        height: 20,
                                      ),
                                      Text(
                                        orders![index].products[0].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      CustomSpacer(
                                        height: 5,
                                      ),
                                      Text(
                                        orders![index].products[0].description,
                                        style: TextStyle(),
                                      ),
                                      CustomSpacer(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
