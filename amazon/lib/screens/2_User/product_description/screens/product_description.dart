import 'package:amazon/utils/exports.dart';

class ProductDescription extends StatefulWidget {
  static const String routeName = "/description";
  final Product product;
  const ProductDescription({super.key, required this.product});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  //puting initial values
  double avgRatings = 0;
  double myRatings = 0;
  //instance of product services
  ProductServices productServices = ProductServices();
//update ratings
  @override
  void initState() {
    super.initState();
    double totalRatings = 0;
    if (widget.product.rating != null) {
      for (int i = 0; i < widget.product.rating!.length; i++) {
        totalRatings += widget.product.rating![i].rating;
        //checking user
        if (widget.product.rating![i].userId ==
            Provider.of<UserProider>(context, listen: false).user.id) {
          myRatings = widget.product.rating![i].rating;
        }
      }
    }
    //adding avg rating
    if (totalRatings != 0 &&
        widget.product.rating != null &&
        widget.product.rating!.isNotEmpty) {
      avgRatings = totalRatings / widget.product.rating!.length;
    }
  }

  void addToCart() {
    ProductServices().addToCart(context: context, product: widget.product);
    showSnackBar(context, "product added to cart");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CartScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leadingWidth: 15,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  //shhowing avg ratings
                  Ratings(rating: avgRatings),
                ],
              ),
            ),
            CustomSpacer(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
              child: Text(
                widget.product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider(
              items: widget.product.images
                  .map(
                    (images) => Builder(
                      builder: (context) {
                        return Image.network(
                          images,
                          fit: BoxFit.contain,
                          height: 350,
                          width: double.infinity,
                        );
                      },
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 350,
                viewportFraction: 1,
                autoPlay: true,
              ),
            ),
            Container(
              height: 10,
              color: Colors.black12,
            ),
            CustomSpacer(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    "Deal Price: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${widget.product.price} Rs",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Text(widget.product.description),
            ),
            Container(
              height: 10,
              color: Colors.black12,
            ),
            CustomSpacer(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: widget.product.quantity == 0
                  ? CustomButton(
                      text: "Sorry Out Of Stock",
                      onTap: () => showSnackBar(context,
                          "Sorry ${widget.product.name}, is out of stock now"),
                      red: true,
                    )
                  : CustomButton(
                      text: "Buy Now",
                      onTap: () {},
                    ),
            ),
            CustomSpacer(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: widget.product.quantity == 0
                  ? CustomButton(
                      text: "Sorry Out Of Stock",
                      onTap: () => showSnackBar(context,
                          "Sorry ${widget.product.name}, is out of stock now"),
                      red: true,
                    )
                  : CustomButton(
                      text: "Add To Cart",
                      color: true,
                      //adding it to cart
                      onTap: addToCart,
                    ),
            ),
            CustomSpacer(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Rate The Product",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            //adding ratings
            RatingBar.builder(
              initialRating: myRatings,

              minRating: 1,
              allowHalfRating: true,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              itemBuilder: (context, _) {
                return Icon(
                  Icons.star,
                  color: AppStyles.secondaryColor,
                );
              },
              //updating ratings
              onRatingUpdate: (rating) {
                productServices.rateProduct(
                  context: context,
                  rating: rating,
                  product: widget.product,
                );
              },
            ),
            CustomSpacer(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
