import 'package:amazon/utils/exports.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
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
