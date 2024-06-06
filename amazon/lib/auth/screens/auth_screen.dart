import 'package:amazon/utils/exports.dart';

enum Auth {
  signIn,
  singUp,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //auth services instance
  final AuthServices _authServices = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  Auth _auth = Auth.singUp;

  //sign up logic
  void userSignUp() {
    _authServices.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

//sign in logic
  void userSignIn() {
    _authServices.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.greyBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              ListTile(
                tileColor: _auth == Auth.singUp
                    ? AppStyles.backgroundColor
                    : AppStyles.greyBackgroundColor,
                title: const Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                leading: Radio(
                    activeColor: AppStyles.secondaryColor,
                    value: Auth.singUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.singUp)
                Form(
                    key: _signUpFormKey,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: AppStyles.backgroundColor,
                      child: Column(
                        children: [
                          CustomTextFeild(
                            text: "name",
                            controller: _nameController,
                          ),
                          addVerticleSpace(10),
                          CustomTextFeild(
                            text: "email",
                            controller: _emailController,
                          ),
                          addVerticleSpace(10),
                          CustomTextFeild(
                            text: "password",
                            controller: _passwordController,
                          ),
                          addVerticleSpace(10),
                          CustomButton(
                              text: "Create account",
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  userSignUp();
                                }
                              }),
                          addVerticleSpace(2),
                        ],
                      ),
                    )),
              ListTile(
                tileColor: _auth == Auth.signIn
                    ? AppStyles.backgroundColor
                    : AppStyles.greyBackgroundColor,
                title: const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                leading: Radio(
                    activeColor: AppStyles.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signIn)
                Form(
                    key: _signInFormKey,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Column(
                        children: [
                          CustomTextFeild(
                            text: "email",
                            controller: _emailController,
                          ),
                          addVerticleSpace(10),
                          CustomTextFeild(
                            text: "password",
                            controller: _passwordController,
                          ),
                          addVerticleSpace(10),
                          CustomButton(
                              text: "Sign In",
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  userSignIn();
                                }
                              }),
                          addVerticleSpace(2),
                        ],
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
