import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  //sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, "Account is created! login in  with your creditials.");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        //now just encoding comming data
        body: jsonEncode(
          {
            "email": email,
            'password': password,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProider>(context, listen: false).setUser(res.body);
          await prefs.setString('auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, MyHomeScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      return showSnackBar(context, e.toString());
    }
  }
}
