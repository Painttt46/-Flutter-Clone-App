import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
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
              top: 55,
              left: 20,
              child: Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'HELLO !',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 85,
              left: 20,
              child: Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Welcome To Kmunity',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 20,
              child: Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'INFORMATION',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('information')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> documents = snapshot.data!.docs;

                      return CarouselSlider(
                        items: documents.map((document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Image.network(
                                    data['image'],
                                    fit: BoxFit.fill, // ย่อให้ภาพเต็มพื้นที่
                                    width: double.infinity,
                                    height: 150,
                                    alignment: Alignment.center,
                                  ),
                                  Positioned(
                                    height: 100,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(
                                            0.7), // เพิ่มการทำให้พื้นหลังของข้อความมีความโปร่งใส
                                        
                                      ),
                                      child: Text(
                                        data['text'],
                                        textAlign: TextAlign
                                            .center, // จัดให้ข้อความอยู่กึ่งกลาง
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(height: 250),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
            Positioned(
              top: 430,
              left: 20,
              child: Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'MOVIE',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 435,
              left: 20,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 400, // กำหนดความสูงของ ListView
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Item 1',
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Item 2',
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left:
                                    8.0), // กำหนดระยะห่างระหว่างรูปภาพกับข้อความ
                            child: Image.asset(
                              'assets/images/Dno.jpg', // เพิ่มรูปภาพตามที่คุณต้องการ
                              width: 50, // กำหนดความกว้างของรูปภาพ
                              height: 50, // กำหนดความสูงของรูปภาพ
                              fit: BoxFit.cover, // กำหนดการแสดงผลของรูปภาพ
                            ),
                          ),
                          const SizedBox(
                              width:
                                  8), // เพิ่ม SizedBox เพื่อสร้างระยะห่างระหว่างรูปภาพกับข้อความ
                          const Text(
                            'Item 2',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
