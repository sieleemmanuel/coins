import 'package:coins/ui/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home: const OnBoarding(),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255,50,119,248),
        scaffoldBackgroundColor: Colors.white
      ),
    );
  }
}
