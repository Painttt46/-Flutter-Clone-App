import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:kmunity_se/AllDetailsScreen/detailboardgame_screen.dart';
import 'package:kmunity_se/Auth/authentication.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';

class bookingboardgamescreen extends StatefulWidget {
  bookingboardgamescreen({
    super.key,
  });

  @override
  State<bookingboardgamescreen> createState() => _bookingboardgamescreenState();
}

class _bookingboardgamescreenState extends State<bookingboardgamescreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _documents = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    QuerySnapshot snapshot = await _firestore.collection('boardgame').get();
    setState(() {
      _documents = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String collection1 = "boardgame";
    
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
              top: 95,
              left: 50,
              right: 50,
              child: Center(
                child: Text(
                  "Booking Boardgame",
                  style: GoogleFonts.inter(
                    // textStyle: Theme.of(context).textTheme.titleLarge,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
                            SizedBox(width: 75,),
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
                                        "เลือกบอร์ดเกม",
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
                            SizedBox(width: 75,)
                          ],
                        ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
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
                            List d = document["Detail"];
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x0FFF7200),
                                    // color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        detailboardgamescreen(
                                                            document["Name"],
                                                            d,
                                                            document["image"],
                                                            document.id,
                                                            collection1,
                                                            document)),
                                              );
                                            },
                                            child: Container(
                                              width: 250,
                                              height: 80,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5.0, 0, 0, 0),
                                                child: Image.network(
                                                    document["image"]),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Container(
                                                child: Text(
                                              document["Name"],
                                              style: GoogleFonts.inter(
                                                // textStyle: Theme.of(context).textTheme.titleLarge,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                              softWrap: true,
                                              maxLines: 1,
                                            )),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              // color: Colors.cyan,
                                              width: 256,
                                              height: 120,
                                              child: SingleChildScrollView(
                                                child: Center(
                                                  child: Text(
                                                    document["info"],
                                                    style: GoogleFonts.inter(
                                                      // textStyle: Theme.of(context).textTheme.titleLarge,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore
                                                  .instance
                                                  .collection('user')
                                                  .doc(user!.uid)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  bool Data = snapshot.data
                                                      ?.data()?['have_boardgame'];
                                                  return ElevatedButton(
                                                    onPressed:
                                                        document["status"] ||
                                                                Data
                                                            ? () {
                                                                showAwesomeDialog3(
                                                                    context);
                      
                                                                // print("พอเเล้วพอเสียที");
                                                              }
                                                            : () {
                                                                showAwesomeDialog(
                                                                    context,
                                                                    document,
                                                                    collection1);
                                                              },
                                                    style: document["status"]
                                                        ? ElevatedButton
                                                            .styleFrom(
                                                            primary:
                                                                Colors.red,
                                                            onPrimary:
                                                                Colors.white,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5,
                                                                    horizontal:
                                                                        5), // การระบุขนาดของปุ่ม
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            elevation: 5,
                                                          )
                                                        : ElevatedButton
                                                            .styleFrom(
                                                            primary:
                                                                Colors.orange,
                                                            onPrimary:
                                                                Colors.white,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5,
                                                                    horizontal:
                                                                        5), // การระบุขนาดของปุ่ม
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            elevation: 5,
                                                          ),
                                                    child: document["status"]
                                                        ? Text(
                                                            "ถูกยืมเเล้ว",
                                                            style: GoogleFonts
                                                                .inter(
                                                              // textStyle: Theme.of(context).textTheme.titleLarge,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                          )
                                                        : Text(
                                                            "จอง",
                                                            style: GoogleFonts
                                                                .inter(
                                                              // textStyle: Theme.of(context).textTheme.titleLarge,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white,
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
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
              FirebaseAuthService().Update_User_board(d["ID"],d["Name"]);
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
