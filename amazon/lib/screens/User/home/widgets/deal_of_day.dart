import 'package:amazon/utils/exports.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Deal of the day",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
          ),
          CustomSpacer(
            height: 5,
          ),
          Container(
            height: 200,
            width: 300,
            child: Image.asset(
              "assets/images/slide_images/1717568262498.jpg",
              fit: BoxFit.cover,
            ),
          ),
          CustomSpacer(
            height: 5,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "\$20",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          CustomSpacer(
            height: 5,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Product name",
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          CustomSpacer(
            height: 5,
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/slide_images/1717568262498.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/images/slide_images/1717568262498.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/images/slide_images/1717568262498.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/images/slide_images/1717568262498.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/images/slide_images/1717568262498.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/images/slide_images/1717568262498.jpg",
                    fit: BoxFit.cover,
                  ),
                ],
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
              style:
                  TextStyle(color: AppStyles.selectedNavBarColor, fontSize: 16),
            ),
          ),
          CustomSpacer(
            height: 20,
          )
        ],
      ),
    );
  }
}
