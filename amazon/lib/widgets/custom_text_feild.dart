import 'package:amazon/utils/exports.dart';

class CustomTextFeild extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const CustomTextFeild({
    required this.controller,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: text,
          labelText: text,
          border: const OutlineInputBorder(
            gapPadding: 20,
            borderSide: BorderSide(color: Colors.black38),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$text is required";
        } else {
          return null;
        }
      },
    );
  }
}
