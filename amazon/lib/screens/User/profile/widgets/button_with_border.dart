import 'package:flutter/material.dart';

class ButtonWithBorder extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const ButtonWithBorder({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(width: 2, color: Colors.black45),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          )),
        ),
      ),
    );
  }
}
