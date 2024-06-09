import 'package:amazon/utils/exports.dart';

class SpecificCategory extends StatefulWidget {
  final String Category;
  static const String routeName = "/orders-screen";
  const SpecificCategory({super.key, required this.Category});

  @override
  State<SpecificCategory> createState() => _SpecificCategoryState();
}

class _SpecificCategoryState extends State<SpecificCategory> {
  ProductCategorySevice productCategorySevice = ProductCategorySevice();
  List<Product>? productList;
  bool isloading = true;
  @override
  void initState() {
    getProductWithSpecificCategory();
    super.initState();
  }

  void getProductWithSpecificCategory() async {
    productList = await productCategorySevice.getProductWithCategory(
        context: context, category: widget.Category);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppStyles.appBarGradient,
            ),
            width: double.infinity,
          ),
          backgroundColor: AppStyles.selectedNavBarColor,
          title: Text(
            widget.Category,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: isloading
          ? CustomProgressIndicator()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Keep shoping for, ",
                        style: TextStyle(color: AppStyles.selectedNavBarColor),
                      ),
                      Text(
                        widget.Category + " ...",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppStyles.selectedNavBarColor,
                        ),
                      ),
                    ],
                  ),
                  CustomSpacer(
                    height: 20,
                  ),
                  SizedBox(
                    height: 170,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.4),
                      itemBuilder: (context, index) {
                        //initalizing product
                        final product = productList![index];
                        //navigate to product description page fpr each product.
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, ProductDescription.routeName,
                              arguments: product),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(
                                      product.images[0],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  left: 0,
                                  top: 5,
                                  right: 15,
                                ),
                                child: Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
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
