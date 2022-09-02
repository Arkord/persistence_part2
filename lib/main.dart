import 'package:flutter/material.dart';
import 'package:persistence1/screens/home_screen.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SqliteApp());
}

class SqliteApp extends StatelessWidget {
  const SqliteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQLite Examle',
      initialRoute: 'home',
      routes: {
        'home':(context) => const HomeScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF38004D)
        )
      ),
    );
  }
}