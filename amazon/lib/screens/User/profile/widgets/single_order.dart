import 'package:flutter/material.dart';

class SingleOrder extends StatelessWidget {
  final String img;
  const SingleOrder({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        width: 210,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1.2, color: Colors.black38),
        ),
        child: Image.network(
          img,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
