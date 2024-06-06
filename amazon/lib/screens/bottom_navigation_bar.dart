import 'package:amazon/utils/exports.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});
  static const String routeName = '/bottomNav';
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int isSelected = 0;
  final List _items = const <Widget>[
    MyHomeScreen(),
    ProfileScreen(),
    CartScreen(),
  ];

  void changeIndex(int index) {
    setState(() {
      isSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          //profile
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
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: 'profile',
          ),
          //cart
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
              child: const Badge(
                  label: Text('2'), child: Icon(Icons.shopping_cart_rounded)),
            ),
            label: 'shoping_cart',
          ),
        ],
      ),
    );
  }
}
