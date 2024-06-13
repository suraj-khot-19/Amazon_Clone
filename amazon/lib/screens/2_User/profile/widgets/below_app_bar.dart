import 'package:amazon/utils/exports.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProider>(context).user;
    return Container(
      margin: null,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(gradient: AppStyles.appBarGradient),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: "Hello, ",
                style: const TextStyle(fontSize: 22, color: Colors.black),
                children: [
                  TextSpan(
                    text: user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 22),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
