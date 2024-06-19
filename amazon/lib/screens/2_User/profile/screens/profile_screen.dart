import 'package:amazon/screens/2_User/profile/screens/your_orders.dart';
import 'package:amazon/utils/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
//conform lgout
  void confirmLogout(User user) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: Icon(Icons.person),
            content: Text("${user.name.toUpperCase()} are you sure to Logout?"),
            actionsPadding: EdgeInsets.symmetric(horizontal: 20),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () => ProfileServices().logout(context: context),
                  child: Text("Logout")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProider>(context, listen: false).user;
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
                  onTap: () =>
                      Navigator.pushNamed(context, YourOrders.routeName)),
              ButtonWithBorder(
                text: "Your Cart",
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
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
                onTap: () => confirmLogout(user),
              ),
              ButtonWithBorder(
                text: "Your Wish List",
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
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
                  onTap: () {
                    Navigator.pushNamed(context, YourOrders.routeName);
                  },
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
