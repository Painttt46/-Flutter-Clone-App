import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kmunity_se/Auth/authentication.dart';
import 'package:kmunity_se/Screens/BookingBoardgame_screen.dart';
import 'package:kmunity_se/Screens/BookingBook_screen.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';
import "package:google_fonts/google_fonts.dart";

class detailboardgamescreen extends StatefulWidget {
  final String Namebook;
  final List Detailbook;
  final String image;
  final String documentID;
  final String collec;
  final DocumentSnapshot d;

  detailboardgamescreen(this.Namebook, this.Detailbook, this.image,
      this.documentID, this.collec, this.d);

  @override
  State<detailboardgamescreen> createState() => _detailboardgamescreenState();
}

class _detailboardgamescreenState extends State<detailboardgamescreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                              builder: (context) => bookingboardgamescreen()),
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
                    "Booking Book",
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
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(15, 255, 174, 0),

                          // color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 250,
                        height: 50,
                        child: Center(
                          child: Text(
                            "รายละเอียดหนังสือ",
                            style: GoogleFonts.inter(
                              // textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Container(
                          height: 140,
                          width: 210,
                          // color: Colors.amber,
                          child: Image.network(widget.image)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.Namebook,
                        style: GoogleFonts.inter(
                          // textStyle: Theme.of(context).textTheme.titleLarge,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF5B5B),
                        ),
                      ),
                      Container(
                        height: 200,
                        width:300 ,
                        // color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    widget.Detailbook[0],
                                    style: GoogleFonts.inter(
                                      // textStyle: Theme.of(context).textTheme.titleLarge,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.Detailbook[1],
                                    style: GoogleFonts.inter(
                                      // textStyle: Theme.of(context).textTheme.titleLarge,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.Detailbook[2],
                                    style: GoogleFonts.inter(
                                      // textStyle: Theme.of(context).textTheme.titleLarge,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.Detailbook[3],
                                    style: GoogleFonts.inter(
                                      // textStyle: Theme.of(context).textTheme.titleLarge,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    widget.Detailbook[4],
                                    style: GoogleFonts.inter(
                                      // textStyle: Theme.of(context).textTheme.titleLarge,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .doc(user!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              bool Data = snapshot.data?.data()?['have_boardgame'];
                              return ElevatedButton(
                                onPressed: widget.d["status"] || Data
                                    ? () {
                                        showAwesomeDialog3(context);
                                      }
                                    : () {
                                        showAwesomeDialog(
                                            context, widget.d, widget.collec);
                                      },
                                style: widget.d["status"]
                                    ? ElevatedButton.styleFrom(
                                        primary:
                                            Colors.red, // สีพื้นหลังของปุ่ม
                                        onPrimary: Colors
                                            .white, // สีของตัวอักษรภายในปุ่ม
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                25), // การระบุขนาดของปุ่ม
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20)), // การปรับรูปร่างของปุ่มเป็นรูปร่างวงกลม
                                        elevation: 5, // การกำหนดเงาของปุ่ม
                                      )
                                    : ElevatedButton.styleFrom(
                                        primary:
                                            Colors.orange, // สีพื้นหลังของปุ่ม
                                        onPrimary: Colors
                                            .white, // สีของตัวอักษรภายในปุ่ม
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                25), // การระบุขนาดของปุ่ม
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20)), // การปรับรูปร่างของปุ่มเป็นรูปร่างวงกลม
                                        elevation: 5, // การกำหนดเงาของปุ่ม
                                      ),
                                child: widget.d["status"]
                                    ? Text(
                                        "ถูกยืมเเล้ว",
                                        style: GoogleFonts.inter(
                                          // textStyle: Theme.of(context).textTheme.titleLarge,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "จอง",
                                        style: GoogleFonts.inter(
                                          // textStyle: Theme.of(context).textTheme.titleLarge,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  
  void showAwesomeDialog(
      BuildContext context, DocumentSnapshot d, String collection1) {
    AwesomeDialog(
      context: context,
      title: 'ยืนยันการยืมหนังสือ',
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 246, 121, 112),
      ),
      btnOkOnPress: d["status"]
          ? () {
              showAwesomeDialog3(context);
            }
          : () {
              showAwesomeDialog2(context);
              FirebaseAuthService().Update_User_board(d["ID"],d['Name']);
              FirebaseAuthService().Update_Board(collection1, d["ID"], true);
              FirebaseAuthService().Update_user_board1(true);
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
            title: 'การยืมสำเร็จ',
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

  void showAwesomeDialog3(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: 'การยืมล้มเหลวโปรดลองใหม่อีกครั้ง',
      desc: "มีการยืมหนังสือไปเเล้วหรือคุณมีหนังสือที่ยืมอยู่เเล้ว",
      descTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 250, 200, 197),
      ),
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 246, 121, 112),
      ),
      btnCancelOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bookingboardgamescreen()),
        );
      },
      btnCancelColor: const Color.fromARGB(255, 246, 121, 112),
      btnCancelText: "กลับไปยังหน้าหลัก",
    ).show();
  }
}
