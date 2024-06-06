import 'package:amazon/utils/exports.dart';

class CustomTextFeild extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextEditingController controller;
  const CustomTextFeild({
    this.maxLines = 1,
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
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          )),
      maxLines: maxLines,
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
