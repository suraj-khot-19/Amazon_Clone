import 'package:amazon/utils/exports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final bool color;
  final bool? red;
  const CustomButton({
    this.isLoading = false,
    super.key,
    required this.text,
    required this.onTap,
    this.color = false,
    this.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: red == null
            ? color
                ? Colors.amberAccent
                : AppStyles.secondaryColor
            : Colors.black26,
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
                      color: red == null
                          ? color
                              ? Colors.black
                              : Colors.white
                          : Colors.red,
                      fontSize: 20),
                ),
        ),
      ),
    );
  }
}
