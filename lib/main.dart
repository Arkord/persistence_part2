import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:persistence1/screens/home_screen.dart';
import 'package:persistence1/screens/taken_picture_screen.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  //Get available cameras
  final cameras = await availableCameras();

  //Get a specific camera from the list of available cameras
  final firstCamera = cameras.first;

  runApp(SqliteApp(firstCamera: firstCamera,));
}

class SqliteApp extends StatelessWidget {
  final CameraDescription firstCamera;
  const SqliteApp({Key? key, required this.firstCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQLite Example',
      initialRoute: 'home',
      routes: {
        'home':(context) => TakePictureScreen(
          camera: firstCamera,
        )
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF38004D)
        )
      ),
    );
  }
}