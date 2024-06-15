import 'package:amazon/utils/exports.dart';

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

  @override
  Widget build(BuildContext context) {
    return sales == null || totalEarnings == null
        ? CustomProgressIndicator()
        : Column(
            children: [
              Text(
                "${totalEarnings}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 350,
                child: SfCartesianChart(
                  series: <CartesianSeries<Sales, String>>[
                    BarSeries(
                        xValueMapper: (Sales s, _) => s.label,
                        yValueMapper: (Sales s, _) => s.earning),
                  ],
                ),
              ),
            ],
          );
  }
}

/*
 child: SfCartesianChart(
                  
                  series: [
                    LineSeries<Sales, String>(
                        dataSource: sales,
                        xValueMapper: (Sales value, _) => value.label,
                        yValueMapper: (Sales value, _) => value.earning)
                  ],
                ),
*/