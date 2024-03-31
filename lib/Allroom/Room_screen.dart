import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:kmunity_se/AllDetailsScreen/detailboardgame_screen.dart';
import 'package:kmunity_se/Allroom/selectroom_screen.dart';
import 'package:kmunity_se/Screens/bottom_nav.dart';

class bookingroomscreen extends StatefulWidget {
  bookingroomscreen({
    super.key,
  });

  @override
  State<bookingroomscreen> createState() => _bookingroomscreenState();
}

class _bookingroomscreenState extends State<bookingroomscreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _documents = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    QuerySnapshot snapshot = await _firestore.collection('room').get();
    setState(() {
      _documents = snapshot.docs;
    });
  }

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
                  "Booking Room",
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
                                        "เลือกห้อง",
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
                    Padding(padding: EdgeInsets.only(top: 2.5)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        // color: Colors.blue,
                        width: 350,
                        height: 450,
                      
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(15, 255, 174, 0),
                                    // color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 0, 0, 0)),
                                      Container(
                                        width: 125,
                                        height: 120,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 0, 0, 0),
                                          child: Image.network(
                                              document["image"]),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        // color: Colors.amber,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  // color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 5,
                                                      color: Color.fromARGB(
                                                          160, 72, 72, 72),
                                                      offset: Offset(0, 0),
                                                    )
                                                  ],
                                                ),
                                                // color: Colors.cyan,
                                                width: 100,
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    document["Name"],
                                                    style: GoogleFonts.inter(
                                                      // textStyle: Theme.of(context).textTheme.titleLarge,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                    softWrap: true,
                                                    maxLines: 1,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                // color: Colors.cyan,
                                                width: 200,
                                                height: 80,
                                                child: SingleChildScrollView(
                                                  child: Center(
                                                    child: Text(
                                                      document["Detail"],
                                                      style:
                                                          GoogleFonts.inter(
                                                        // textStyle: Theme.of(context).textTheme.titleLarge,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          selectroomscreen(document)),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.orange,
                                                onPrimary: Colors.white,
                      
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal:
                                                        5), // การระบุขนาดของปุ่ม
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                elevation: 5,
                                              ),
                                              child: Text(
                                                "จอง",
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
