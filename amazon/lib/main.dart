import 'package:amazon/utils/exports.dart';

void main() {
  runApp(
      //register provider
      MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GloabalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: GloabalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthScreen(),
    );
  }
}
