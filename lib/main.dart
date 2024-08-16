import 'package:ewallet/utils/colors.dart';
import 'package:ewallet/views/splash/splash_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Firebase
  await Firebase.initializeApp();
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
          useMaterial3: true,
          scaffoldBackgroundColor: Appcolor.background,
          // appBarTheme: const AppBarTheme(
          //     backgroundColor: deepBlackColor,
          //     elevation: 0.00,
          //     surfaceTintColor: deepBlackColor),
          colorScheme: ColorScheme.light(
              surface: Appcolor.background, primary: Appcolor.primary),
          primaryTextTheme: TextTheme(
            headlineSmall: TextStyle(color: Appcolor.darkText),
          )),
      home: const SplashScreenView(), //NavView()
    );
  }
}
