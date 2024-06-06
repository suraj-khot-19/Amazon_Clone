import 'package:amazon/utils/exports.dart';

class AdminAddProduct extends StatefulWidget {
  static const String routeName = "/addProduct";
  const AdminAddProduct({super.key});

  @override
  State<AdminAddProduct> createState() => _AdminAddProductState();
}

class _AdminAddProductState extends State<AdminAddProduct> {
  String selectedCategory = 'Mobiles';
  List<File> productImage = [];

  TextEditingController _productController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
//menue button fun
  void updateCategory(String? NewCategory) {
    setState(() {
      selectedCategory = NewCategory!;
    });
  }

//fun to display image in dotted box
  void selectImg() async {
    //util>file_picker
    var resultImages = await addProductImage().filePicker();
    setState(() {
      productImage = resultImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
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
              "Add Product",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          child: Column(
            children: [
              //checking is image selected
              productImage.isNotEmpty
                  ? CarouselSlider(
                      items: productImage
                          .map(
                            (images) => Builder(
                              builder: (context) {
                                return Image.file(
                                  images,
                                  fit: BoxFit.fitWidth,
                                  height: 200,
                                  width: double.infinity,
                                );
                              },
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1,
                        autoPlay: true,
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImg,
                      child: DottedBorder(
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        strokeCap: StrokeCap.round,
                        dashPattern: [10, 4],
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 150,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_copy_outlined,
                                size: 35,
                              ),
                              CustomSpacer(
                                height: 5,
                              ),
                              Text(
                                "Select Product Images",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              CustomSpacer(
                height: 30,
              ),
              CustomTextFeild(
                  controller: _productController, text: "Product Name"),
              CustomSpacer(
                height: 10,
              ),
              CustomTextFeild(
                controller: _descriptionController,
                text: "Discription",
                maxLines: 7,
              ),
              CustomSpacer(
                height: 10,
              ),
              CustomTextFeild(controller: _priceController, text: "Price"),
              CustomSpacer(
                height: 10,
              ),
              CustomTextFeild(
                  controller: _quantityController, text: "Quantity"),
              CustomSpacer(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: selectedCategory,
                  items: categoriesList.map((String category) {
                    return DropdownMenuItem(
                        value: category, child: Text(category));
                  }).toList(),
                  onChanged: updateCategory,
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              CustomSpacer(
                height: 10,
              ),
              CustomButton(text: "Sell", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

  List<String> categoriesList = <String>[
    "Fashion",
    "Mobiles",
    "Fresh",
    "Electronics",
    "MiniTV",
    "Home",
    "Deals",
    "Beauty",
    "Appliances",
    "Books",
    "Everyday",
  ];
  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    _productController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
