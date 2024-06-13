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

  //changing order status ****************only for admin**********************
  final AdminServices adminServices = AdminServices();
  void changeOrderStatus(int status) {
    adminServices.changeStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            //when done button clicked current state will+1
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProider>(context).user;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.2,
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.network(
                              widget.order.products[i].images[0],
                              height: 150,
                              width: 150,
                            ),
                            CustomSpacer(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.products[i].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Quantity: ${widget.order.quantity[i]}",
                                  ),
                                  Text(
                                    "Price: ${widget.order.products[i].price}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                    return
                        //cheking a type as admin
                        user.type == "admin"
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: CustomButton(
                                  text: "Done",
                                  onTap: () =>
                                      changeOrderStatus(details.currentStep),
                                ),
                              )
                            : SizedBox();
                  },
                  steps: [
                    Step(
                      title: Text("Pending"),
                      content: user.type == "admin"
                          ? Text("Is order is ready to deliver?")
                          : Text(
                              "Your order is yet to be delivered",
                            ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Text("Completed"),
                      content: user.type == "admin"
                          ? Text("Is Order is delivered to amazon Buddy?")
                          : Text(
                              "Your order has been delivered, you are yet to sign.",
                            ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Text("Received"),
                      content: user.type == "admin"
                          ? Text("Is Order signed by customer?")
                          : Text(
                              "Your order has been delivered, and signed by you.",
                            ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Text("Delivered"),
                      content: user.type == "admin"
                          ? Text(
                              "Is Order Delivered and Payment Confirmed Successfully?")
                          : Text(
                              "Your order has been delivered, and signed by you.",
                            ),
                      isActive: currentStep == 3,
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
      ),
    );
  }
}
