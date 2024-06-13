import 'package:amazon/utils/exports.dart';

class CrousalImg extends StatelessWidget {
  const CrousalImg({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> netImages = [
      "assets/images/slide_images/1717568262498.jpg",
      "assets/images/slide_images/1717568262503.jpg",
      "assets/images/slide_images/1717568262508.jpg",
      "assets/images/slide_images/1717568262513.jpg",
      "assets/images/slide_images/1717568262519.jpg",
      "assets/images/slide_images/1717568262525.jpg",
      "assets/images/slide_images/1717568262533.jpg",
      "assets/images/slide_images/1717568262539.jpg",
    ];
    return GestureDetector(
      onTap: () => showSnackBar(context, "please search for product"),
      child: CarouselSlider(
        items: netImages
            .map(
              (images) => Builder(
                builder: (context) {
                  return Image.asset(
                    images,
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: double.infinity,
                  );
                },
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 200,
          viewportFraction: 1,
          autoPlay: true,
        ),
      ),
    );
  }
}
