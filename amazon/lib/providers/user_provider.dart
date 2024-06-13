import 'package:amazon/utils/exports.dart';

class UserProider with ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );
  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  //function for set user
  void setUserFromMode(User user) {
    _user = user;
    notifyListeners();
  }
}
