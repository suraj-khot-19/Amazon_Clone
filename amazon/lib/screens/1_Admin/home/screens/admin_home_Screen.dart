import 'package:amazon/utils/exports.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final AdminServices adminServices = AdminServices();
  //creating list
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

//fetch product
  fetchProducts() async {
    products = await adminServices.getProduct(context);
    setState(() {});
  }

//delete product
  void deleteProduct(Product product, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: Icon(Icons.delete_forever_outlined),
            content: Text("Are you sure to delete ${product.name} product"),
            actionsPadding: EdgeInsets.symmetric(horizontal: 20),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    adminServices.deleteProduct(
                        context: context,
                        product: product,
                        runToDelete: () {
                          //passing index with removeAt func and to replicate using setState
                          products!.removeAt(index);
                          showSnackBar(
                              context, "${product.name}, is deleted! ");
                          setState(() {
                            Navigator.pop(context);
                          });
                        });
                  },
                  child: Text("Delete")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? CustomProgressIndicator()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                  itemCount: products!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: SingleOrder(
                            img: productData.images[0],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              InkWell(
                                onTap: () => deleteProduct(productData, index),
                                child: Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppStyles.selectedNavBarColor,
              tooltip: "Add Product",
              onPressed: () {
                Navigator.pushNamed(context, AdminAddProduct.routeName);
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 40,
              ),
            ),
          );
  }
}
