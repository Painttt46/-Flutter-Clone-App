import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kmunity_se/AllDetailsScreen/detailbook_screen.dart';
import 'package:kmunity_se/Auth/authentication.dart';
import 'package:kmunity_se/Screens/BookingBook_screen.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';
import "package:google_fonts/google_fonts.dart";

class electronicbook extends StatefulWidget {
  const electronicbook({super.key});

  @override
  State<electronicbook> createState() => _electronicbookState();
}

class _electronicbookState extends State<electronicbook> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _documents = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    QuerySnapshot snapshot = await _firestore.collection('electronicbook').get();
    setState(() {
      _documents = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String collection1 = "electronicbook";
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
                              builder: (context) => bookingbookscreen()),
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
                          width: 180,
                          height: 50,
                          child: Center(
                            child: Text(
                              "อิเล็กทรอนิกส์",
                              style: GoogleFonts.inter(
                                // textStyle: Theme.of(context).textTheme.titleLarge,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                       Padding(padding: EdgeInsets.only(top: 2.5)),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            // color: Colors.blue,
                            width: width - 80,
                            height: height * 0.60,
                            // width: 290,
                            // height: 450,
                          
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1, // จำนวนคอลัมน์ในแต่ละแถว
                                childAspectRatio:
                                    1.5, // สัดส่วนของความสูงต่อความกว้าง
                              ),
                              itemCount: _documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot document = _documents[index];
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      // color: Colors.blueGrey,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        detailbookscreen(
                                                            document["Name"],
                                                            document[
                                                                "Detail"],
                                                            document["image"],
                                                            document.id,
                                                            collection1,document)),
                                              );
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 120,
                                              child: Image.network(
                                                  document["image"]),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            // color: Colors.amber,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    // color: Colors.cyan,
                                                    width: 200,
                                                    height: 20,
                                                    child: Text(
                                                      document["Name"],
                                                      style:
                                                          GoogleFonts.inter(
                                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                      ),
                                                      softWrap: true,
                                                      maxLines: 1,
                                                    )),
                                                Container(
                                                    // color: Colors.cyan,
                                                    width: 200,
                                                    height: 75,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Center(
                                                        child: Text(
                                                          document["info"],
                                                          style: GoogleFonts
                                                              .inter(
                                                            // textStyle: Theme.of(context).textTheme.titleLarge,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            color: Color
                                                                .fromARGB(255,
                                                                    0, 0, 0),
                                                          ),
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('user')
                                                        .doc(user!.uid)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        bool Data = snapshot.data?.data()?['have_book'];
                                                        return ElevatedButton(
                                                          onPressed: document[
                                                                  "status"] || Data
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
                                                          style: document[
                                                                  "status"]
                                                              ? ElevatedButton
                                                                  .styleFrom(
                                                                  primary:
                                                                      Colors
                                                                          .red,
                                                                  onPrimary:
                                                                      Colors
                                                                          .white,
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          5), // การระบุขนาดของปุ่ม
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(20)),
                                                                  elevation:
                                                                      5,
                                                                )
                                                              : ElevatedButton
                                                                  .styleFrom(
                                                                  primary: Colors
                                                                      .orange,
                                                                  onPrimary:
                                                                      Colors
                                                                          .white,
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          5), // การระบุขนาดของปุ่ม
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(20)),
                                                                  elevation:
                                                                      5,
                                                                ),
                                                          child: document[
                                                                  "status"]
                                                              ? Text(
                                                                  "ถูกยืมเเล้ว",
                                                                  style: GoogleFonts
                                                                      .inter(
                                                                    // textStyle: Theme.of(context).textTheme.titleLarge,
                                                                    fontSize:
                                                                        17,
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
                                                                    fontSize:
                                                                        17,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )))
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
              FirebaseAuthService().Update_User(d["ID"],d['Name']);
              FirebaseAuthService().Update_Book(collection1, d["ID"], true);
              FirebaseAuthService().Update_user1(true);
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
          MaterialPageRoute(builder: (context) => bookingbookscreen()),
        );
      },
      btnCancelColor: const Color.fromARGB(255, 246, 121, 112),
      btnCancelText: "กลับไปยังหน้าหลัก",
    ).show();
  }
}
