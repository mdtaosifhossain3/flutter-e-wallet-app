import 'package:ewallet/views/splash/splash_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize dotenv
  await dotenv.load(fileName: '.env');

  String name = dotenv.get("name", fallback: "");
  String apiKey = dotenv.get("apiKey", fallback: "");
  String appId = dotenv.get("appId", fallback: "");
  String messagingSenderId = dotenv.get("messagingSenderId", fallback: "");
  String projectId = dotenv.get("projectId", fallback: "");
  String storageBucket = dotenv.get("storageBucket", fallback: "");

  //Initialize Firebase
  await Firebase.initializeApp(
      name: name,
      options: FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
          storageBucket: storageBucket));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreenView(), //NavView()
    );
  }
}
