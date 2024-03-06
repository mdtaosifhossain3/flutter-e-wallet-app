import 'package:ewallet/views/splash/splash_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDQjr98osFA_zr-Er2YPbJq4S00ejsrqEo",
          appId: "1:1016716052482:android:184dbb453b3dd7694ebf1b",
          messagingSenderId: "1016716052482",
          projectId: "clone-bf8a3",
          storageBucket: "gs://clone-bf8a3.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
