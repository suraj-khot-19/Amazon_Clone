import 'package:amazon/utils/exports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final bool color;
  const CustomButton({
    this.isLoading = false,
    super.key,
    required this.text,
    required this.onTap,
    this.color = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: color ? Colors.amberAccent : AppStyles.secondaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () => onTap(),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  text,
                  style: TextStyle(
                      color: color ? Colors.black : Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }
}
