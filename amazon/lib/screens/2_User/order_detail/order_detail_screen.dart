import 'package:amazon/utils/exports.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = "/order-details";
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          leadingWidth: 20,
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
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "View Oder Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.2,
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //formating date using intl
                  Text(
                      "Order Date:      ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}"),
                  Text("Order ID:          ${widget.order.id}"),
                  Text("Order Total:     ${widget.order.totalPrice}"),
                ],
              ),
            ),
            CustomSpacer(
              height: 10,
            ),
            Text(
              "Purchase Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.2,
                  color: Colors.black12,
                ),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Image.network(
                          widget.order.products[i].images[0],
                          height: 120,
                          width: 120,
                          fit: BoxFit.contain,
                        ),
                        CustomSpacer(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Quantity: ${widget.order.quantity[i]}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  CustomSpacer(
                    height: 10,
                  )
                ],
              ),
            ),
            CustomSpacer(
              height: 10,
            ),
            Text(
              "Tracking",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              padding: EdgeInsets.all(5),
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.2,
                  color: Colors.black12,
                ),
              ),
              child: Stepper(
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  return SizedBox();
                },
                steps: [
                  Step(
                    title: Text("Pending"),
                    content: Text(
                      "Your order is yet to be delivered",
                    ),
                    isActive: currentStep > 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Completed"),
                    content: Text(
                      "Your order has been delivered, you are yet to sign.",
                    ),
                    isActive: currentStep > 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Received"),
                    content: Text(
                      "Your order has been delivered, and signed by you.",
                    ),
                    isActive: currentStep > 2,
                    state: currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Delivered"),
                    content: Text(
                      "Your order has been delivered, and signed by you.",
                    ),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
