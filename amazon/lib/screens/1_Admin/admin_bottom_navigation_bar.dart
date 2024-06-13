import 'package:amazon/screens/1_Admin/all_inbox/admin_order_details.dart';
import 'package:amazon/utils/exports.dart';

class AdminBottomBar extends StatefulWidget {
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => AdminBottomBarState();
}

class AdminBottomBarState extends State<AdminBottomBar> {
  int isSelected = 0;
  final List _items = const <Widget>[
    AdminHome(),
    Center(
      child: Text("1"),
    ),
    AdminOrderDetails(),
  ];

  void changeIndex(int index) {
    setState(() {
      isSelected = index;
    });
  }

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
              Text(
                "Hello, Admin",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: _items[isSelected],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppStyles.backgroundColor,
        currentIndex: isSelected,
        onTap: changeIndex,
        selectedItemColor: AppStyles.selectedNavBarColor,
        unselectedItemColor: AppStyles.unselectedNavBarColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          //home
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(bottom: 10, top: 2),
              width: 30,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: 5,
                color: isSelected == 0
                    ? AppStyles.selectedNavBarColor
                    : AppStyles.backgroundColor,
              ))),
              child: const Icon(Icons.home),
            ),
            label: 'home',
          ),

          //analytics
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(bottom: 10, top: 2),
              width: 30,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: 5,
                color: isSelected == 1
                    ? AppStyles.selectedNavBarColor
                    : AppStyles.backgroundColor,
              ))),
              child: const Icon(Icons.analytics),
            ),
            label: 'analytics',
          ),
          //inbox
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(bottom: 10, top: 2),
              width: 30,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: 5,
                color: isSelected == 2
                    ? AppStyles.selectedNavBarColor
                    : AppStyles.backgroundColor,
              ))),
              child: Icon(Icons.all_inbox_rounded),
            ),
            label: 'Inbox',
          ),
        ],
      ),
    );
  }
}
