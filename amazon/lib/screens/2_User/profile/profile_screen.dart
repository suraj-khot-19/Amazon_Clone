import 'package:amazon/utils/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          backgroundColor: AppStyles.selectedNavBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/amazon.png",
                    color: Colors.black,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                    ),
                    const CustomSpacer(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppBar(),
          const CustomSpacer(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWithBorder(
                text: "Your Orders",
                onTap: () {},
              ),
              ButtonWithBorder(
                text: "Turn Seller",
                onTap: () {},
              )
            ],
          ),
          const CustomSpacer(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWithBorder(
                text: "Log Out",
                onTap: () {},
              ),
              ButtonWithBorder(
                text: "Your Wish List",
                onTap: () {},
              )
            ],
          ),
          const CustomSpacer(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your Orders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "See all",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          const CustomSpacer(
            height: 30,
          ),
          const OrderList()
        ],
      ),
    );
  }
}
