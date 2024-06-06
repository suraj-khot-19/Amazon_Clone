import 'package:amazon/utils/exports.dart';

class MyHomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: const Column(
          children: [
            AddressBar(),
            CustomSpacer(height: 15),
            OrderTypeRow(),
            CustomSpacer(height: 15),
            CrousalImg(),
            CustomSpacer(height: 10),
            DealOfDay()
          ],
        ),
      ),
    );
  }
}
