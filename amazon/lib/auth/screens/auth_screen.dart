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
  bool _obscureText = true;
  bool _isLoading = false;

  //sign up logic
  Future<void> userSignUp() async {
    setState(() {
      _isLoading = true;
    });
    await _authServices.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
    setState(() {
      _isLoading = false;
    });
  }

//sign in logic
  Future<void> userSignIn() async {
    setState(() {
      _isLoading = true;
    });
    await _authServices.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

//clearing controllers
  void clearController() {
    _emailController.clear();
    _nameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.greyBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/amazon.png",
                    color: Colors.black,
                    width: 200,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
                CustomSpacer(
                  height: 50,
                ),
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
                          clearController();
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
                            CustomSpacer(
                              height: 10,
                            ),
                            CustomTextFeild(
                              text: "email",
                              controller: _emailController,
                            ),
                            CustomSpacer(
                              height: 10,
                            ),
                            CustomTextFeild(
                              text: "password",
                              controller: _passwordController,
                              widget: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              obsecure: _obscureText,
                            ),
                            CustomSpacer(
                              height: 10,
                            ),
                            CustomButton(
                                isLoading: _isLoading,
                                text: "Create account",
                                onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    userSignUp();
                                  }
                                }),
                            CustomSpacer(
                              height: 2,
                            ),
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
                          clearController();
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
                          CustomSpacer(
                            height: 10,
                          ),
                          CustomTextFeild(
                            text: "password",
                            controller: _passwordController,
                            widget: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            obsecure: _obscureText,
                          ),
                          CustomSpacer(
                            height: 10,
                          ),
                          CustomButton(
                              isLoading: _isLoading,
                              text: "Sign In",
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  userSignIn();
                                }
                              }),
                          CustomSpacer(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                CustomSpacer(
                  height: 80,
                ),
                Center(
                  child: Text(
                    "Made with 💛 by SurajKhot",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
