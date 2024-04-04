import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kmunity_se/AllDetailsScreen/detailboardgame_screen.dart';
import 'package:kmunity_se/AllDetailsScreen/detailbook_screen.dart';

import 'package:kmunity_se/BookingScreen/mathbook_screen.dart';
import 'package:kmunity_se/Screens/BookingBoardgame_screen.dart';
import 'package:kmunity_se/Screens/Login_screen.dart';
import 'package:kmunity_se/Allroom/Room_screen.dart';
import 'package:kmunity_se/Screens/User_screen.dart';
import 'package:kmunity_se/Screens/admin_Screen/edit_book.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:kmunity_se/component/databaseuser.dart';
import 'package:kmunity_se/firebase_options.dart';
import 'package:kmunity_se/splash/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title : 'Kmunity',
      //  home: Bottomnavigationbar(),
        routes: {
        '/': (context) => SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginScreen(),
        ),
        '/login': (context) => LoginScreen(),
        '/user': (context) =>  Bottomnavigationbar(),
        '/admin': (context) =>  Bottomnavigationbar(),
      },

    );
}}
