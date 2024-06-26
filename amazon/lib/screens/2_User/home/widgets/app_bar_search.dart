import 'package:amazon/utils/exports.dart';

class AppBarSearch extends StatefulWidget {
  const AppBarSearch({super.key});

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  void NavigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //search bar
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: 15,
            ),
            height: 42,
            child: Material(
              //for white color border radius
              borderRadius: BorderRadius.circular(7),
              elevation: 1,

              child: TextFormField(
                //passing value to search screen
                onFieldSubmitted: NavigateToSearchScreen,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search Amazon.in",
                  contentPadding: const EdgeInsets.only(top: 10, left: 8),
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                      color: Colors.black),
                  //search icon
                  suffixIcon: Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.amber[300],
                    ),
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.black45),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
          ),
        ),
        //mic btn
        Container(
          height: 42,
          color: Colors.transparent,
          margin: const EdgeInsets.only(
            left: 15,
          ),
          child: const Icon(
            Icons.mic,
            color: Colors.black,
            size: 28,
          ),
        ),
      ],
    );
  }
}
