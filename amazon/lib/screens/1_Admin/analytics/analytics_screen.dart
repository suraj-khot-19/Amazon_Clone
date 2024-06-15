import 'package:amazon/utils/exports.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalEarnings;
  List<Sales>? sales;

  @override
  void initState() {
    super.initState();
    getAnalytics();
  }

  void getAnalytics() async {
    var analyticsData = await adminServices.viewAnalytics(context: context);
    sales = analyticsData['sales'];
    totalEarnings = analyticsData['totalEarnings'];
    setState(() {});
  }

  String formatCurrency(int number) {
    final format = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
    return format.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return sales == null || totalEarnings == null
        ? CustomProgressIndicator()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Earnings : ${formatCurrency(totalEarnings!)}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SfCartesianChart(
                    title: ChartTitle(
                        text: "**Analytics based on Category**",
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 18)),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    primaryXAxis: CategoryAxis(
                      interval: 1,
                      labelRotation: 90,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    series: <CartesianSeries<dynamic, dynamic>>[
                      ColumnSeries<Sales, String>(
                        dataSource: sales!,
                        xValueMapper: (Sales s, _) => s.label,
                        yValueMapper: (Sales s, _) => s.earning,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
