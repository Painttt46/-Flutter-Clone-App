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

class moviescreen extends StatefulWidget {
  @override
  State<moviescreen> createState() => _moviescreenState();
}

class _moviescreenState extends State<moviescreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _documents = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    QuerySnapshot snapshot = await _firestore.collection('movieselect').get();
    setState(() {
      _documents = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;

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
                    "Movie",
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
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 50,),
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xFFFF7302),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 10,
                                          color: Color.fromARGB(161, 110, 110, 110),
                                          offset: Offset(0, 0),
                                        )
                                      ],
                                    ),
                        
                                    child: Center(
                                      child: Text(
                                        "โหวดหนังประจำสัปดาห์",
                                        style: GoogleFonts.inter(
                                          // textStyle: Theme.of(context).textTheme.titleLarge,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            SizedBox(width: 50,)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                         Container(
                            // color: Colors.blue,
                            width: 350,
                            height: 450,

                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, // จำนวนคอลัมน์ในแต่ละแถว
                            childAspectRatio:
                                1, // สัดส่วนของความสูงต่อความกว้าง
                          ),
                          itemCount: _documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = _documents[index];
                            return
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  Color.fromARGB(255, 255, 243, 234)),
                        child: Center(
                          child: Column(
                            children: [
                        Padding(
                            padding:
                                EdgeInsets.only(top: 15)),
                        Container(
                          width: 175,
                          height: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(
                                    5.0, 0, 0, 0),
                            child: Image.network(
                                document["image"]),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            child: Text(
                          document["Name"],
                          style: GoogleFonts.inter(
                            // textStyle: Theme.of(context).textTheme.titleLarge,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            // color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          softWrap: true,
                          maxLines: 1,
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(user!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                bool Data =
                                    snapshot.data?.data()?[
                                        'have_vote_movie'];
                                return ElevatedButton(
                                  onPressed: Data
                                      ? () {
                                          showAwesomeDialog3(
                                              context);
                                        }
                                      : () {
                                          showAwesomeDialog(
                                              context,
                                              document);
                                        },
                                  style: ElevatedButton
                                      .styleFrom(
                                    primary: Colors.orange,
                                    onPrimary: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal:
                                            5), // การระบุขนาดของปุ่ม
                                    shape:
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                                        20)),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    "โหวด",
                                    style: GoogleFonts.inter(
                                      // textStyle: Theme.of(context).textTheme.titleLarge,
                                      fontSize: 17,
                                      fontWeight:
                                          FontWeight.bold,
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
                        ),
                        ),
                        );
                          },
                        ),
                          ),
                        
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  void showAwesomeDialog(BuildContext context, DocumentSnapshot d) {
    AwesomeDialog(
      context: context,
      title: 'คุณต้องการโหวตหนังเรื่องนี้ ?',
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 246, 121, 112),
      ),
      btnOkOnPress: () {
        FirebaseAuthService().Vote1(d["ID"]);
        FirebaseAuthService().Vote(true);
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
            title: 'การโหวดสำเร็จ',
            titleTextStyle: GoogleFonts.inter(
              // textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            desc: "รอประกาศผลโหวตได้ที่หน้าเมนูหลักในแต่สัปดาห์",
            descTextStyle: GoogleFonts.inter(
              // textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 63, 70, 65),
            ),
            btnCancelOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bottomnavigationbar()),
              );
            },
            btnCancelColor: const Color.fromARGB(255, 112, 157, 114),
            btnCancelText: "กลับไปหน้าหลัก")
        .show();
  }

  void showAwesomeDialog3(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: 'ไม่สามารถโหวดได้',
      titleTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 246, 121, 112),
      ),
      desc: "เนื่องจากสามารถโหวตได้เพียงบัญชีละ 1 ครั้งเท่านัั้น",
      descTextStyle: GoogleFonts.inter(
        // textStyle: Theme.of(context).textTheme.titleLarge,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 63, 70, 65),
      ),
      btnCancelOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bottomnavigationbar()),
        );
      },
      btnCancelColor: const Color.fromARGB(255, 246, 121, 112),
      btnCancelText: "กลับไปหน้าหลัก",
    ).show();
  }
}
