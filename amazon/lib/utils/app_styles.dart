import 'package:amazon/utils/exports.dart';

// String uri = 'http://<IP Address>:3000';

class AppStyles {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    // stops: [0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}

List<String> dealImg = [
  "https://m.media-amazon.com/images/I/B1xWNAn+paL._SX3000_.jpg",
  ""
];
