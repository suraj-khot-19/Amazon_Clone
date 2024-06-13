import 'package:amazon/utils/exports.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProider>(context).user;
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(225, 144, 226, 221),
            Color.fromARGB(225, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: Colors.black,
            size: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Dilvery to ${user.name} - ${user.address}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2, right: 2),
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
