import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


    
@override

  void initState() {
    
    _route();
  
    Future.delayed(
      Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome To Kmunity",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

 Future<void> _route() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String? role = prefs.getString('userRole');
    switch (role) {
      case "user":
        Navigator.pushReplacementNamed(context, "/user");
        break;
      case "admin":
        Navigator.pushReplacementNamed(context, "/admin");
        break;
    }
    
    }
}
