import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmunity_se/Auth/authentication.dart';
import 'package:kmunity_se/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mailscreen extends StatelessWidget {
  mailscreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuthService a = FirebaseAuthService();
    String uid = a.userid();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List imgIcon = [
      "assets/images/book.png",
      "assets/images/meeting.png",
      "assets/images/boardgame.png",
    ];
    //  List text = [
    //   "assets/images/book.png",
    //   "assets/images/meeting.png",
    //   "assets/images/boardgame.png",

    // ];

    List text = ["เช็คหนังสือที่ยืม", "เช็คห้องที่จอง", "เช็คบอร์ดเกมที่ยืม"];
    List doc = ["Status_check", "Status_room", "Status_boardgame"];
    List text2 = [
      "หนังสือของคุณที่ยืม",
      "ห้องที่คุณจองอยู่",
      "บอร์ดเกมของคุณที่ยืม"
    ];

    return Scaffold(
      backgroundColor: Colors.orange,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF7500), Colors.white],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.17, // เลื่อน Container สีเทาอยู่สูงขึ้น
              child: Align(
                alignment: Alignment
                    .bottomCenter, // จัด Text ไว้ที่ด้านล่างของ Container
                child: Transform.translate(
                  offset: Offset(0, -30), // ลองปรับค่า offset เพื่อเลื่อนขึ้น
                  child: Text(
                    "MAILBOX",
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  0, 0, 0, 0), // เพิ่มความสูงด้านบนเป็น 40
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color(0xA2000000),
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                height: height * 0.7, // ความสูงของ Container เท่าเดิม
                width: width - 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListView.builder(
                    itemCount: 3, // จำนวนรายการที่ต้องการสร้าง
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .doc(uid)
                              .collection("status_user")
                              .doc(doc[index])
                              .snapshots(),
                          builder: (context, snapshot) {
                            List aa = [
                              snapshot.data?.data()?['Name'],
                              snapshot.data?.data()?['Name'],
                              snapshot.data?.data()?['Name'],
                            ];
                            if (snapshot.hasData) {
                              return InkWell(
                                onTap: () {
                                  showAwesomeDialog(context,text2[index] ,aa[index]);
                                  // print(aa[index]);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 100,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 231, 211),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width:
                                              8), // เพิ่มช่องว่างด้านซ้ายของ Container สีส้ม
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 193, 139), // สีเท่า
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            imgIcon[index],
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              16), // เพิ่มช่องว่างระหว่าง Container
                                      Text(
                                        text[index],
                                        style: GoogleFonts.inter(
                                          // textStyle: Theme.of(context).textTheme.titleLarge,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAwesomeDialog(BuildContext context, String d ,String c) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      title: d,
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 39, 40, 39),
      ),
      desc: c,
      descTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 96, 96, 96),
      ),
      btnOkOnPress: () {},
      btnOkColor: const Color.fromARGB(255, 112, 157, 114),
      btnOkText: "ตกลง",
    ).show();
  }

  void showAwesomeDialog1(BuildContext context, String d) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      title: d,
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 246, 121, 112),
      ),
      btnOkOnPress: () {},
      btnOkColor: const Color.fromARGB(255, 112, 157, 114),
      btnOkText: "ตกลง",
      btnCancelOnPress: () {},
    ).show();
  }
}
