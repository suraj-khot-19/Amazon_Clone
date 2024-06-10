import 'package:amazon/utils/exports.dart';

void main() {
  runApp(
    //register provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthServices authServices = AuthServices();
  @override
  void initState() {
    super.initState();
    authServices.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amazon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppStyles.backgroundColor,
          colorScheme:
              const ColorScheme.light(primary: AppStyles.secondaryColor),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProider>(context).user.token.isNotEmpty
            ? Provider.of<UserProider>(context).user.type == "user"
                ? const BottomNavigation()
                : AdminBottomBar()
            : const AuthScreen());
  }
}
