import 'package:amazon/screens/2_User/address/services/address_services.dart';
import 'package:amazon/utils/exports.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmt;
  const AddressScreen({super.key, required this.totalAmt});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController flatController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressUsingUser = "";
//using address services
  final AddressService addressService = AddressService();
  List<PaymentItem> paymentItems = [];
  @override
  void initState() {
    paymentItems.add(PaymentItem(
        amount: widget.totalAmt,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
    super.initState();
  }

//onPaymentResult
  void onGooglePayResult(res) {
    if (Provider.of<UserProider>(context, listen: false).user.address.isEmpty) {
      //updating user address using services
      addressService.saveUserAddress(
          context: context, address: addressUsingUser);
    }
    addressService.placeOrder(
        context: context,
        address: addressUsingUser,
        totalSum: double.parse(widget.totalAmt));
  }

  //to check whic address is using user
  void runOnPayPress(String addressFromProvider) {
    addressUsingUser = "";
    bool isUsingForm = flatController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pinController.text.isNotEmpty;
    if (isUsingForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressUsingUser =
            "${flatController.text}, ${areaController.text}, ${cityController.text}, ${pinController.text}";
      } else {
        throw Exception("please enter all the values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressUsingUser = addressFromProvider;
    } else {
      showSnackBar(context, "Error");
    }
  }

  @override
  void dispose() {
    flatController.dispose();
    areaController.dispose();
    pinController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<UserProider>(context).user.address;
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
        ),
      ),
      //checking address
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              address.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(31, 176, 64, 64),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 30,
                          child: Text(
                            address,
                            style: TextStyle(
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        CustomSpacer(
                          height: 12,
                        ),
                        Center(
                          child: Text(
                            "OR",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : Form(
                      key: _addressFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSpacer(
                              height: 12,
                            ),
                            CustomTextFeild(
                              controller: flatController,
                              text: "Flat, House no. Building",
                            ),
                            CustomSpacer(
                              height: 8,
                            ),
                            CustomTextFeild(
                              controller: areaController,
                              text: "Area, Street",
                            ),
                            CustomSpacer(
                              height: 8,
                            ),
                            CustomTextFeild(
                              controller: pinController,
                              text: "Pincode",
                              type: TextInputType.number,
                            ),
                            CustomSpacer(
                              height: 8,
                            ),
                            CustomTextFeild(
                              controller: cityController,
                              text: "Town/City",
                            ),
                            CustomSpacer(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
              //pay button
              GooglePayButton(
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString("googlepay.json"),
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.all(8.0),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPressed: () => runOnPayPress(address),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
