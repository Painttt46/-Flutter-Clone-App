import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:kmunity_se/BookingScreen/astronomybook_screen.dart';
import 'package:kmunity_se/BookingScreen/cartoonbook.dart';
import 'package:kmunity_se/BookingScreen/electronicbook_screen.dart';
import 'package:kmunity_se/BookingScreen/mathbook_screen.dart';
import 'package:kmunity_se/BookingScreen/plantsbook_screen.dart';
import 'package:kmunity_se/BookingScreen/sciencebook_screen.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';
import 'package:kmunity_se/Screens/menu_screen.dart';
import 'package:kmunity_se/component/my_button.dart';


class bookingbookscreen extends StatefulWidget {
  bookingbookscreen({
    super.key,
  });

  @override
  State<bookingbookscreen> createState() => _bookingbookscreenState();
}

class _bookingbookscreenState extends State<bookingbookscreen> {
  List imgIcon = [
    "assets/images/book.png",
    "assets/images/meeting.png",
    "assets/images/boardgame.png",
    "assets/images/movie.png",
    "assets/images/feedback.png",
    "assets/images/feedback.png",
  ];

  List imgName = [
    "คณิตศาสตร์",
    "วิทยาศาสตร์",
    "อิเล็กทรอนิกส์",
    "พืช เเละ สวน",
    "ดาราศาตร์",
    "มังงะ เเละ การ์ตูน"
  ];

  List totap = [
    mathbook(),
    sciencebook(),
    electronicbook(),
    plantsbook(),
    astronomybook(),
    cartoonbook()
  ];

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
                  "Booking Book",
                  style: GoogleFonts.inter(
                    // textStyle: Theme.of(context).textTheme.titleLarge,
                    fontSize: 35,
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
              child: Center(
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
                  child: 
                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // จำนวนคอลัมน์ในแต่ละแถว
                          childAspectRatio: 3, // สัดส่วนของความสูงต่อความกว้าง
                        ),
                        itemCount: imgIcon.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => totap[index]),
                          );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(15, 255, 174, 0),
                                    // color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 100,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, top: 5.0, bottom: 5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.orange, // สีของเส้นขอบ
                                              width: 5, // ความกว้างของเส้นขอบ
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              imgIcon[index],
                                              width: 45,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:40),
                                        child: Text(
                                          imgName[index],
                                          style: GoogleFonts.inter(
                                            // textStyle: Theme.of(context).textTheme.titleLarge,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
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
}
