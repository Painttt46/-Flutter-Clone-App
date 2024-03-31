import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:kmunity_se/component/edit_info.dart';

class AdminInfoPage extends StatefulWidget {
  const AdminInfoPage({Key? key}) : super(key: key);

  @override
  State<AdminInfoPage> createState() => _AdminInfoPageState();
}

class _AdminInfoPageState extends State<AdminInfoPage> {
  TextEditingController textController = TextEditingController();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  Future<void> _uploadImageAndSaveData() async {
    if (_selectedImage == null) return;
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDireImages = referenceRoot.child('info/');
    Reference referenceImageToUpload = referenceDireImages.child(fileName);

    try {
      await referenceImageToUpload.putFile(
        File(_selectedImage!.path),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Get the download URL of the uploaded image
      String downloadURL = await referenceImageToUpload.getDownloadURL();

      // Save data to Firestore
      await FirebaseFirestore.instance.collection('information').add({
        'image': downloadURL,
        'text': textController.text,
      });

      // Reset fields
      setState(() {
        _selectedImage = null;
        textController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('อัปโหลดและบันทึกข้อมูลสำเร็จ')),
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('มีข้อผิดพลาด: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกข้อมูล Admin'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField(
            //   controller: imageController,
            //   decoration: InputDecoration(labelText: 'ข้อความ'),
            // ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('เลือกรูปภาพ'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'ข้อความ'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _uploadImageAndSaveData,
              child: Text('บันทึกข้อมูล'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('information')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.separated(
                    itemCount: snapshot.data.docs.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(), // เพิ่มเส้นแบ่งระหว่างรายการ
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot info = snapshot.data.docs[index];
                      return Container(
                        color: Colors.grey[200], // กำหนดสีพื้นหลังให้กับรายการ
                        child: ListTile(
                          title: Center(child: Text(info['text'])),
                          leading: Image.network(info['image']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // โค้ดสำหรับปุ่ม Update
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditInfoPage(info: info),
                                    ),
                                  );
                                  // สามารถเข้าถึงข้อมูลของรายการนี้ผ่านตัวแปร infof
                                  // เช่น info.id เป็นไอดีของเอกสารนี้
                                  // และ info.data() เป็นข้อมูลทั้งหมดในเอกสารนี้
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // โค้ดสำหรับปุ่ม Delete
                                  // สามารถลบเอกสารนี้ได้โดยใช้ info.reference.delete()
                                  info.reference.delete();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
