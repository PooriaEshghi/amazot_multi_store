// import 'package:amazot_multi_store/views/buyers/auth/login_screen.dart';
import 'package:amazot_multi_store/views/buyers/auth/login_screen.dart';
import 'package:amazot_multi_store/views/buyers/main_screen.dart';
import 'package:amazot_multi_store/views/buyers/nav_screens/account_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Bold',
      ),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
