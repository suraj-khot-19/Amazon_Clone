import 'package:amazon/utils/exports.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProider>(context).user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
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
      body: ListView(scrollDirection: Axis.vertical, children: [
        Column(
          children: [
            AddressBar(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: "Proceed To Buy (${user.cart.length} items)",
                onTap: () => Navigator.pushNamed(
                    context, AddressScreen.routeName,
                    arguments: sum.toString()),
                color: true,
              ),
            ),
            CustomSpacer(
              height: 15,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            CustomSpacer(
              height: 5,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ]),
    );
  }
}
