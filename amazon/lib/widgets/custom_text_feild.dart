import 'package:amazon/utils/exports.dart';

class CustomTextFeild extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextInputType type;
  final TextEditingController controller;
  final Widget? widget;
  final bool obsecure;
  const CustomTextFeild({
    this.type = TextInputType.text,
    this.maxLines = 1,
    required this.controller,
    required this.text,
    super.key,
    this.widget,
    this.obsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecure,
      keyboardType: type,
      decoration: InputDecoration(
          suffix: widget,
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
