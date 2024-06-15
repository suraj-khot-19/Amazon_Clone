import 'package:amazon/utils/exports.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProider>(context, listen: false).user;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "${user.name}, You CanNot modify your data!",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
          ),
          CustomSpacer(
            height: 20,
          ),
          Container(
            height: 150,
            padding: EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name:${user.name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Email:${user.email}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Address:${user.address}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "ID:${user.id}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          CustomSpacer(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
