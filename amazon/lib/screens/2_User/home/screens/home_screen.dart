import 'package:amazon/screens/2_User/home/services/fetch_all_product.dart';
import 'package:amazon/utils/exports.dart';

class MyHomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final FetchAllProduct fetchAllProduct = FetchAllProduct();
  List<Product>? product;
//updating ratings
  double rating = 0;

  @override
  void initState() {
    super.initState();
    fetchingAllProduct();
  }

  void fetchingAllProduct() async {
    product = await fetchAllProduct.getAllProduct(
      context: context,
    );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBar(),
            CustomSpacer(height: 15),
            OrderTypeRow(),
            CustomSpacer(height: 15),
            CrousalImg(),
            CustomSpacer(height: 10),
            DealOfDay(),
            CustomSpacer(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "   New Product's only for you",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
            if (product == null)
              CustomProgressIndicator()
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: product!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, ProductDescription.routeName,
                              arguments: product![index]),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Image.network(
                                  product![index].images[0],
                                  height: 150,
                                  width: 160,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              CustomSpacer(
                                width: 5,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 12.0,
                                      bottom: 12.0,
                                      right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          product![index].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Ratings(
                                        rating:
                                            product![index].rating![0].rating,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "\₹ ${product![index].price}",
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
                                      product![index].quantity == 0
                                          ? Text(
                                              "Out Of Stock",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              "In Stock",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppStyles
                                                      .selectedNavBarColor),
                                            ),
                                      Text(
                                          "save upto ₹${product![index].price * 0.10}"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomSpacer(
                          height: 30,
                        )
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
