import 'package:amazon/utils/exports.dart';

class YourOrders extends StatefulWidget {
  static const String routeName = "/odereds";
  const YourOrders({super.key});

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
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
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppStyles.appBarGradient,
            ),
            width: double.infinity,
          ),
          title: Text("Your All Orders"),
          centerTitle: true,
        ),
      ),
      body: orders == null
          ? CustomProgressIndicator()
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, OrderDetailsScreen.routeName,
                              arguments: orders![index]),
                          child: SizedBox(
                            height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 200,
                                  child: Image.network(
                                    orders![index].products[0].images[0],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          orders![index].products[0].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "\₹ ${orders![index].products[0].price}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
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
                                                color:
                                                    AppStyles.secondaryColor),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Quantity You are Buying:" +
                                            orders![index]
                                                .products[0]
                                                .quantity
                                                .toString(),
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppStyles.selectedNavBarColor),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
