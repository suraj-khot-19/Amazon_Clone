import 'package:amazon/widgets/custom_spacer.dart';
import 'package:flutter/material.dart';

class SingleOrder extends StatelessWidget {
  final String img;
  final bool? isChange;
  final String? passTheText;
  const SingleOrder(
      {super.key, required this.img, this.isChange, this.passTheText});

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
          child: isChange == null
              ? Image.network(
                  img,
                  fit: BoxFit.contain,
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Image.network(
                        img,
                        fit: BoxFit.contain,
                      ),
                    ),
                    CustomSpacer(
                      height: 3,
                    ),
                    Text(
                      passTheText!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
    );
  }
}
