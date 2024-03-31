import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmunity_se/Auth/authentication.dart';
import 'package:kmunity_se/Screens/Menu_screen.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';
import 'package:kmunity_se/component/my_textfield.dart';

class feedbackscreen extends StatefulWidget {
  const feedbackscreen({super.key});

  @override
  State<feedbackscreen> createState() => _feedbackscreenState();
}

class _feedbackscreenState extends State<feedbackscreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final _inputtitle = TextEditingController();
  final _inputValue = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // final TextEditingController _textEditingController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFF7500), Colors.white],
        )),
        child: Stack(
          children: [
            Positioned(
                top: 48,
                left: 25,
                right: 75,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bottomnavigationbar()),
                        );
                      },
                      child: Icon(
                        Icons.close_sharp,
                        size: 35,
                      ),
                    )
                  ],
                )),
            Positioned(
                top: 80,
                left: 50,
                right: 50,
                child: Center(
                  child: Text(
                    "Feedback",
                    style: GoogleFonts.inter(
                      // textStyle: Theme.of(context).textTheme.titleLarge,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )),
            Positioned(
              top: 140,
              left: 10,
              right: 10,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color.fromARGB(161, 110, 110, 110),
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                width: width - 40,
                height: height * 0.75,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Feedback Category",
                      style: GoogleFonts.inter(
                        // textStyle: Theme.of(context).textTheme.titleLarge,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 64, 64, 64),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     Container(
                      width: 300,
                      child: Column(
                        children: [
                          MyTextField(
                            controller: _inputtitle,
                            hintText: "Enter your title",
                            obscureText: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Message",
                      style: GoogleFonts.inter(
                        // textStyle: Theme.of(context).textTheme.titleLarge,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 64, 64, 64),
                      ),
                    ),
                  
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      child: Column(
                        children: [
                          MyTextField(
                            controller: _inputValue,
                            hintText: "Enter your message",
                            obscureText: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showAwesomeDialog(context, _inputtitle.text.trim(), _inputValue.text.trim());

                        // FirebaseAuthService().AddNote(_inputtitle.text.trim(), _inputValue.text.trim());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5), // การระบุขนาดของปุ่ม
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                      ),
                      
                      child: Text(
                        "SEND",
                        style: GoogleFonts.inter(
                          // textStyle: Theme.of(context).textTheme.titleLarge,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showAwesomeDialog(BuildContext context, String title, String text) {
    AwesomeDialog(
      context: context,
      title: 'ยืนยันข้อมูลการแจ้งปัญหา',
      desc:
          "กรุณาตรวจสอบข้อมูลให้เรียบร้อยก่อนแจ้งปัญหาต่างๆทุกครั้งอย่างถี่ถ้วน",
      descTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 246, 121, 112),
      ),
      btnOkOnPress: () {
        FirebaseAuthService().AddNote(title, text);
        showAwesomeDialog2(context);

      },
      btnOkColor: const Color.fromARGB(255, 112, 157, 114),
      btnOkText: "ยืนยัน",
      btnCancelOnPress: () {},
      btnCancelColor: const Color.fromARGB(255, 246, 121, 112),
      btnCancelText: "ยกเลิก",
    ).show();
  }

  void showAwesomeDialog2(BuildContext context) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            title: 'ได้รับข้มมูลของท่านเรียบร้อย',
            desc: "ขอบคุณที่แจ้งปัญหาเข้ามาเราจะเร่งแก้ปัญหาให้ไวที่สุด",
            descTextStyle: GoogleFonts.inter(
              // textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            titleTextStyle: GoogleFonts.inter(
              // textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            btnCancelOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bottomnavigationbar()),
              );
            },
            btnCancelColor: const Color.fromARGB(255, 112, 157, 114),
            btnCancelText: "กลับไปยังหน้าหลัก")
        .show();
  }

  // void showAwesomeDialog3(BuildContext context) {
  //   AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.error,
  //     title: 'ไ',
  //     desc: "มีการยืมหนังสือไปเเล้วหรือคุณมีหนังสือที่ยืมอยู่เเล้ว",
  //     descTextStyle: GoogleFonts.inter(
  //       // textStyle: Theme.of(context).textTheme.titleLarge,
  //       fontSize: 15,
  //       fontWeight: FontWeight.w700,
  //       color: Color.fromARGB(255, 250, 200, 197),
  //     ),
  //     titleTextStyle: GoogleFonts.inter(
  //       // textStyle: Theme.of(context).textTheme.titleLarge,
  //       fontSize: 25,
  //       fontWeight: FontWeight.bold,
  //       color: const Color.fromARGB(255, 246, 121, 112),
  //     ),
  //     btnCancelOnPress: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => bookingbookscreen()),
  //       );
  //     },
  //     btnCancelColor: const Color.fromARGB(255, 246, 121, 112),
  //     btnCancelText: "กลับไปยังหน้าหลัก",
  //   ).show();
  // }
}
