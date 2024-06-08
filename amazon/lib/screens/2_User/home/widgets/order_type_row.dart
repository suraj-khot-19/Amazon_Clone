import 'package:amazon/utils/exports.dart';

class OrderTypeRow extends StatelessWidget {
  const OrderTypeRow({super.key});

  void returnCategoryPage(BuildContext context, String categoryName) {
    Navigator.pushNamed(context, SpecificCategory.routeName,
        arguments: categoryName);
  }

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> imgList = [
      {
        'images': "assets/images/categories/fashion.jpg",
        "type": "Fashion",
      },
      {
        'images': "assets/images/categories/Mobiles.jpg",
        "type": "Mobiles",
      },
      {
        'images': "assets/images/categories/fresh.jpeg",
        "type": "Fresh",
      },
      {
        'images': "assets/images/categories/electronics.jpg",
        "type": "Electronics",
      },
      {
        'images': "assets/images/categories/minitv.jpg",
        "type": "MiniTV",
      },
      {
        'images': "assets/images/categories/home.jpeg",
        "type": "Home",
      },
      {
        'images': "assets/images/categories/deals.jpg",
        "type": "Deals",
      },
      {
        'images': "assets/images/categories/beauty.jpeg",
        "type": "Beauty",
      },
      {
        'images': "assets/images/categories/appliances.jpg",
        "type": "Appliances",
      },
      {
        'images': "assets/images/categories/books.jpg",
        "type": "Books",
      },
      {
        'images': "assets/images/categories/Everyday.jpg",
        "type": "Everyday",
      },
    ];
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemExtent: 70, //which make it cool bt addding sapce between
        scrollDirection: Axis.horizontal,
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => returnCategoryPage(context, imgList[index]['type']!),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imgList[index]['images']!,
                      fit: BoxFit.fitHeight,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
                Text(
                  imgList[index]['type']!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
