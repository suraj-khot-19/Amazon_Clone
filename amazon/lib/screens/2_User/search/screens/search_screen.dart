import 'package:amazon/utils/exports.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";
  final String search;
  const SearchScreen({super.key, required this.search});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchQuery = SearchServices();

  List<Product>? productList;
  @override
  void initState() {
    getSearchQuery();
    super.initState();
  }

  void getSearchQuery() async {
    productList = await searchQuery.fetchProductWithSearch(
        context: context, searchQuery: widget.search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leadingWidth: 15,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppStyles.appBarGradient,
            ),
            width: double.infinity,
          ),
          title: const AppBarSearch(),
        ),
      ),
      body: productList == null
          ? CustomProgressIndicator()
          : Column(
              children: [
                AddressBar(),
                CustomSpacer(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, ProductDescription.routeName,
                            arguments: productList![index]),
                        child: SearchListProduct(
                          product: productList![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
