import 'package:amazon/utils/exports.dart';

class Ratings extends StatelessWidget {
  final double rating;
  const Ratings({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: AppStyles.secondaryColor,
      ),
      direction: Axis.horizontal,
      itemSize: 15,
      itemCount: 5,
      rating: rating,
    );
  }
}
