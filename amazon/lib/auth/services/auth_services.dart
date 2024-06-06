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

//sign in user
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
              context, BottomNavigation.routeName, (route) => false);
        },
      );
    } catch (e) {
      return showSnackBar(context, e.toString());
    }
  }

  //geting user data
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("auth-token");
      // creating user with  empty token if first time with our app
      if (token == null) {
        prefs.setString('auth-token', '');
      }
      var tokenIsValidResponse = await http.post(
        Uri.parse(
          '$uri/tokenIsValid',
        ),
        //passing 'auth-token':token from above
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token!,
        },
      );
      var tokenResponse = jsonDecode(tokenIsValidResponse.body);
      //geting response in true or flase from our api
      if (tokenResponse == true) {
        //api to get the user data
        http.Response userResponse = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token,
          },
        );
        //passing userResponse if he alredy sign in with to provider
        var userProvider = Provider.of<UserProider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
