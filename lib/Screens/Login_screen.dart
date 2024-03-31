import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kmunity_se/Auth/authentication.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';
import 'package:kmunity_se/Screens/home_screen.dart';
import 'package:kmunity_se/component/my_button.dart';
import 'package:kmunity_se/component/my_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPressed = false;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orange, Colors.white],
        )),
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 50,
              right: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock,
                    size: 75,
                  ),
                  Column(
                    children: [
                      Text(
                        "KMUNITY",
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleLarge,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "SMART LIBRALIAN APPLICATION",
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleLarge,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: 50,
              right: 50,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color(0xA2000000),
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                width: 350,
                height: 400,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            "Welcome",
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            "Login to your account",
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      MyTextField(
                        controller: emailController,
                        hintText: "Enter your email",
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      MyTextField(
                        controller: passwordController,
                        hintText: "Enter your password",
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyButton(onTap: LoginWithEmail, hintText: 'Login')
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 700,
              left: 50,
              right: 50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "If you do not have an account.",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "please contact the ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Text(
                          "Library staff",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LoginWithEmail() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      

      final snapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('id', isEqualTo: user.uid)
          .get();
      final userData = snapshot.docs[0].data();
      if (userData.containsKey('role')) {
        String role = userData['role'];
        String id = userData['id'];
print("Login is successfully signed");
        saveUserRole(role,id);
        route(role);
      } else {
        print('Error: User document does not contain "role" field');
      }
    } else {
      print('Some error happen');
    }
  }

  void saveUserRole(String role,String id) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('role', role);
      prefs.setString('id',id);
    });
    
  }

  void route(String role) {
    switch (role) {
      case "user":
        Navigator.pushReplacementNamed(context, "/user");
        break;
      case "admin":
        Navigator.pushReplacementNamed(context, "/admin");
        break;
      default:
        Navigator.pushReplacementNamed(context, "/");
    }
  }
}
