import 'package:amazon/utils/exports.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  //product
  Product? product;
  //instance of service
  DealOfDayServices dealOfDayServices = DealOfDayServices();
  @override
  void initState() {
    dealOfTheDay();
    super.initState();
  }

  //fun to fetch deal of day
  void dealOfTheDay() async {
    product = await dealOfDayServices.dealOfTheDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: product == null
          ? CustomProgressIndicator()
          : product!.name.isEmpty
              ? const SizedBox()
              : GestureDetector(
                  //navigate to product description
                  onTap: () => Navigator.pushNamed(
                    context,
                    ProductDescription.routeName,
                    arguments: product,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Deal of the day",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                      ),
                      CustomSpacer(
                        height: 5,
                      ),
                      Image.network(
                        product!.images[0],
                        height: 235,
                        fit: BoxFit.fitHeight,
                      ),
                      CustomSpacer(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "₹ ${product!.price}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      CustomSpacer(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          product!.name,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      CustomSpacer(
                        height: 5,
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: product!.images
                                .map(
                                  (e) => Image.network(
                                    e,
                                    fit: BoxFit.contain,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      CustomSpacer(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "See all deals",
                          style: TextStyle(
                              color: AppStyles.selectedNavBarColor,
                              fontSize: 16),
                        ),
                      ),
                      CustomSpacer(
                        height: 20,
                      )
                    ],
                  ),
                ),
    );
  }
}
