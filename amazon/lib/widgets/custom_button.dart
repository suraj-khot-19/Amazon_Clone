import 'package:amazon/utils/exports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: GloabalVariables.secondaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () => onTap,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }
}
