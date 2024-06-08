import 'package:amazon/utils/exports.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppStyles.selectedNavBarColor,
          ),
        ),
        CustomSpacer(
          height: 10,
        ),
        Center(
          child: Text(
            "Loading...",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppStyles.selectedNavBarColor),
          ),
        )
      ],
    );
  }
}
