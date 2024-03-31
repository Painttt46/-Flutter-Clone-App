import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kmunity_se/Allroom/Room_screen.dart';
import 'package:kmunity_se/Auth/authentication.dart';
import 'package:kmunity_se/Screens/BookingBoardgame_screen.dart';
import 'package:kmunity_se/Screens/BookingBook_screen.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';
import "package:google_fonts/google_fonts.dart";

class selectroomscreen extends StatefulWidget {

  final DocumentSnapshot d;
  
  selectroomscreen(this.d);

  @override
  State<selectroomscreen> createState() => _selectroomscreenState();
}

class _selectroomscreenState extends State<selectroomscreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;
    DateTime data = new DateTime.now();

    int h = data.hour;
    int m = data.minute;

    bool t1 = h >= 9;
    bool t11 = h <= 8;

    bool t2 = h >= 10;
    bool t22 = h <= 9; //gap 10-11

    bool t3 = h >= 11;
    bool t33 = h <= 10;

    bool t4 = h >= 12;
    bool t44 = h <= 11;

    bool t5 = h >= 13;
    bool t55 = h <= 12;

    bool t6 = h >= 14;
    bool t66 = h <= 13;

    bool t7 = h >= 15;
    bool t77 = h <= 14;

    bool t8 = h >= 16;
    bool t88 = h <= 15;

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
                    "Booking Room",
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
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .doc(user!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      bool Data = snapshot.data?.data()?['have_room'];
                      return Container(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "เลือกเวลาในการใช้งาน",
                                style: GoogleFonts.inter(
                                  // textStyle: Theme.of(context).textTheme.titleLarge,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (t1 && Data == false ) {
                                        showAwesomeDialog3(context);
                                      } else if (t11 && Data == false && widget.d["t1"] == false ) {
                                        showAwesomeDialog(context,true,widget.d,"t1","9.00 - 10.00");
                                      } 
                                      else {
                                        showAwesomeDialog3(context);
                                      }
                                    },
                                    style: t1 && widget.d["t1"] == false
                                        ? ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color.fromARGB(
                                                255, 148, 148, 148),
                                            side: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 211, 211, 211)),
                                          )
                                        : t11 && widget.d["t1"] == false
                                            ? ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(
                                                    255, 121, 255, 80),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              )
                                            : ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(255, 255, 144, 144),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              ),
                                    child: Text(
                                      "9.00 - 10.00",
                                      style: GoogleFonts.inter(
                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (t5&& Data == false) {
                                        showAwesomeDialog3(context);
                                      } else if (t55&& Data == false&& widget.d["t5"] == false) {
                                       showAwesomeDialog(context,true,widget.d,"t5","13.00 - 14.00");

                                      } 
                                      else {
                                        showAwesomeDialog3(context);
                                      }
                                    },
                                    style: t5&& widget.d["t5"] == false
                                        ? ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color.fromARGB(
                                                255, 148, 148, 148),
                                            side: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 211, 211, 211)),
                                          )
                                        : t55&& widget.d["t5"] == false
                                            ? ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(
                                                    255, 121, 255, 80),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              )
                                            : ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(255, 255, 144, 144),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              ),
                                    child: Text(
                                      "13.00 - 14.00",
                                      style: GoogleFonts.inter(
                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (t2&& Data == false) {
                                        showAwesomeDialog3(context);
                                      } else if (t22&& Data == false) {
                                        showAwesomeDialog(context,true,widget.d,"t2","10.00 - 11.00");
                                      } else {
                                        showAwesomeDialog3(context);
                                      }
                                    },
                                    style: t2&& widget.d["t2"] == false
                                        ? ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color.fromARGB(
                                                255, 148, 148, 148),
                                            side: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 211, 211, 211)),
                                          )
                                        : t22&& widget.d["t2"] == false
                                            ? ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(
                                                    255, 121, 255, 80),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              )
                                            : ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(255, 255, 144, 144),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              ),
                                    child: Text(
                                      "10.00 - 11.00",
                                      style: GoogleFonts.inter(
                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (t6&& Data == false ) {
                                        showAwesomeDialog3(context);
                                      } else if (t66&& Data == false&& widget.d["t6"] == false) {
                                        showAwesomeDialog(context,true,widget.d,"t6","14.00 - 15.00");
                                      } 
                                      else {
                                        showAwesomeDialog3(context);
                                      }
                                    },
                                    style: t6&& widget.d["t6"] == false
                                        ? ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color.fromARGB(
                                                255, 148, 148, 148),
                                            side: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 211, 211, 211)),
                                          )
                                        : t66&& widget.d["t6"] == false
                                            ? ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(
                                                    255, 121, 255, 80),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              )
                                            : ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(255, 255, 144, 144),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              ),
                                    child: Text(
                                      "14.00 - 15.00",
                                      style: GoogleFonts.inter(
                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (t3&& Data == false) {
                                        showAwesomeDialog3(context);
                                      } else if (t11&& Data == false&& widget.d["t3"] == false) {
                                        showAwesomeDialog(context,true,widget.d,"t3","11.00 - 12.00");
                                      } else {
                                        showAwesomeDialog3(context);
                                      }
                                    },
                                    style: t3&& widget.d["t3"] == false
                                        ? ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color.fromARGB(
                                                255, 148, 148, 148),
                                            side: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 211, 211, 211)),
                                          )
                                        : t33&& widget.d["t3"] == false
                                            ? ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(
                                                    255, 121, 255, 80),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              )
                                            : ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(255, 255, 144, 144),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              ),
                                    child: Text(
                                      "11.00 - 12.00",
                                      style: GoogleFonts.inter(
                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (t7&& Data == false) {
                                        showAwesomeDialog3(context);
                                      } else if (t77&& Data == false&& widget.d["t7"] == false) {
                                        showAwesomeDialog(context,true,widget.d,"t7","15.00 - 16.00");
                                      } else {
                                        showAwesomeDialog3(context);
                                      }
                                    },
                                    style: t7&& widget.d["t7"] == false
                                        ? ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color.fromARGB(
                                                255, 148, 148, 148),
                                            side: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 211, 211, 211)),
                                          )
                                        : t77&& widget.d["t7"] == false
                                            ? ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(
                                                    255, 121, 255, 80),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              )
                                            : ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(255, 255, 144, 144),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              ),
                                    child: Text(
                                      "15.00 - 16.00",
                                      style: GoogleFonts.inter(
                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (t4&& Data == false) {
                                        showAwesomeDialog3(context);
                                      } else if (t44&& Data == false&& widget.d["t4"] == false) {
                                        showAwesomeDialog(context,true,widget.d,"t4","12.00 - 13.00");
                                      } else {
                                        showAwesomeDialog3(context);
                                      }
                                    },
                                    style: t4&& widget.d["t4"] == false
                                        ? ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color.fromARGB(
                                                255, 148, 148, 148),
                                            side: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 211, 211, 211)),
                                          )
                                        : t44&& widget.d["t4"] == false
                                            ? ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(
                                                    255, 121, 255, 80),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              )
                                            : ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(255, 255, 144, 144),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              ),
                                    child: Text(
                                      "12.00 - 13.00",
                                      style: GoogleFonts.inter(
                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (t8&& Data == false) {
                                        showAwesomeDialog3(context);
                                      } else if (t88 && Data == false && widget.d["t8"] == false) {
                                        showAwesomeDialog(context,true,widget.d,"t8","16.00 - 17.00");
                                      } else {
                                        showAwesomeDialog3(context);
                                      }
                                    },
                                    style: t8 && widget.d["t8"] == false
                                        ? ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color.fromARGB(
                                                255, 148, 148, 148),
                                            side: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 211, 211, 211)),
                                          )
                                        : t88 && widget.d["t8"] == false
                                            ? ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(
                                                    255, 121, 255, 80),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              )
                                            : ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: Color.fromARGB(255, 255, 144, 144),
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 211, 211, 211)),
                                              ),
                                    child: Text(
                                      "16.00 - 17.00",
                                      style: GoogleFonts.inter(
                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  void showAwesomeDialog(
      BuildContext context, bool d, DocumentSnapshot document,String t , String Time) {
    AwesomeDialog(
      context: context,
      title: 'ยืนยันเวลาจองห้อง',
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 246, 121, 112),
      ),
      desc: Time,
      descTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 250, 200, 197),
      ),
      btnOkOnPress: () {
      FirebaseAuthService().Update_user_room(document["ID"],document["Name"]);
      FirebaseAuthService().Update_user_room2(true);
      FirebaseAuthService().Update_user_room3(t,true,document["ID"]);
      showAwesomeDialog2(context);
      

      },

      btnOkColor: const Color.fromARGB(255, 112, 157, 114),
      btnOkText: "ยืนยัน",
      btnCancelOnPress: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bookingroomscreen()),
        );
      },
      btnCancelColor: const Color.fromARGB(255, 246, 121, 112),
      btnCancelText: "ยกเลิก",
    ).show();
  }

  void showAwesomeDialog2(BuildContext context) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            title: 'การจองห้องสำเร็จ',
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
      title: 'ไม่สามารถเลือกได้',
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 246, 121, 112),
      ),
      desc: "เนื่องจากเกินเวลาที่กำหนด มีนักศึกษาจองห้องไปเเล้ว หรือ คุณได้จองห้องไปเเล้ว",
      descTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 250, 200, 197),
      ),
      btnCancelOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bookingroomscreen()),
        );
      },
      btnCancelColor: const Color.fromARGB(255, 246, 121, 112),
      btnCancelText: "กรุณาเลือกใหม่อีกครั้ง",
    ).show();
  }
}


// else if(t1 && Data == true && widget.d["t1"] == true){
//  FirebaseAuthService().Update_user_room2(false);
//  FirebaseAuthService().Update_user_room3("t1",true,widget.d["t1"]);
// }

//หน้ารีเซ็ต