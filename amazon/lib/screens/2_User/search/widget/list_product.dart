import 'package:amazon/utils/exports.dart';
import 'package:amazon/widgets/ratings.dart';

class SearchListProduct extends StatelessWidget {
  final Product product;
  const SearchListProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //navigate to product descriptin screen for each product
        GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, ProductDescription.routeName,
              arguments: product),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Image.network(
                  product.images[0],
                  height: 130,
                  width: 160,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 12.0, bottom: 12.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Ratings(rating: 3.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\₹ ${product.price}",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
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
                                color: AppStyles.secondaryColor),
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
                      Text(
                        "In Stock",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppStyles.selectedNavBarColor),
                      ),
                      Text("Get it on Friday Aug 19"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
