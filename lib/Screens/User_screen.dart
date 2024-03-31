import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmunity_se/component/My_IconButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmunity_se/component/databaseuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';
import 'package:kmunity_se/Screens/home_screen.dart';
import 'package:kmunity_se/component/my_button.dart';
import 'package:kmunity_se/component/my_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userscreen extends StatefulWidget {
  userscreen({super.key});

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.orange,
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
                  top: 58,
                  left: 50,
                  right: 50,
                  child: Center(
                    child: Text(
                      "PROFILE",
                      style: GoogleFonts.inter(
                        // textStyle: Theme.of(context).textTheme.titleLarge,
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Positioned(
                  top: 112,
                  left: 10,
                  right: 10,
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
                      width: width - 40,
                      height: 145,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              //     .collection('information')
                              // .snapshots(),
                              .collection('user')
                              .doc(user!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List a = [
                                snapshot.data?.data()?['image'],
                                snapshot.data?.data()?['name'],
                                snapshot.data?.data()?['email']
                              ];
                              return Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.amber,
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [Colors.white, Colors.orange],
                                        ),
                                      ),
                                      height: 100,
                                      child: Center(
                                        child: Container(
                                          width: 90,
                                          height: 90,
                                          child: ClipOval(
                                            child: Image.network(
                                              a[0],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 100,
                                        // color: Colors.amber,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              children: [SizedBox(
                                              width: 18,
                                            ),
                                                Text(
                                                  a[1],
                                                  style: GoogleFonts.inter(
                                                    // textStyle: Theme.of(context).textTheme.titleLarge,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(0xFFFF7500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [

                                                SizedBox(
                                              width: 20,
                                            ),
                                                Text(
                                                  a[2],
                                                  style: GoogleFonts.inter(
                                                    // textStyle: Theme.of(context).textTheme.titleLarge,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color(0xFFFF7500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }))),
                          
              Positioned(
                  top: 270,
                  left: 10,
                  right: 10,
                  child: 
                  Container(
                    width: width - 40,
                    height: height * 0.6,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 100,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF7302),
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0xFF000000),
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ข้อมูลส่วนตัว",
                                  style: GoogleFonts.inter(
                                    // textStyle: Theme.of(context).textTheme.titleLarge,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 380,
                          height: 360,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(user!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List Data = [
                                      snapshot.data?.data()?['degree'],
                                      snapshot.data?.data()?['faculty'],
                                      snapshot.data?.data()?['major'],
                                      snapshot.data?.data()?['department'],
                                      snapshot.data?.data()?['id_student']
                                    ];
                                    List topicstu = [
                                      "ระดับ",
                                      "คณะ",
                                      "สาขาวิชา",
                                      "ภาควิชาเรียน",
                                      "รหัสนักศึกษา",
                                    ];
                                    return GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        childAspectRatio: 5,
                                      ),
                                      itemCount: Data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  topicstu[index],
                                                  style: GoogleFonts.inter(
                                                    // textStyle: Theme.of(context).textTheme.titleLarge,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color:
                                                        Color(0xFFFF7200),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  Data[index] ,
                                                  style: GoogleFonts.inter(
                                                    // textStyle: Theme.of(context).textTheme.titleLarge,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800,
                                                    color:
                                                        Color(0xFF818181),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          )),
    );
  }
}
