import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:kmunity_se/component/dropdown_book.dart';
import 'package:kmunity_se/component/edit_book.dart';
import 'package:kmunity_se/component/edit_info.dart';

class adminbook extends StatefulWidget {
  const adminbook({Key? key}) : super(key: key);

  @override
  State<adminbook> createState() => edit_bookstate();
}

class edit_bookstate extends State<adminbook> {
  TextEditingController detailController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  XFile? _selectedImage;
  String selectedCollection = 'Mathbook';

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
      await FirebaseFirestore.instance.collection(selectedCollection).add({
        'image': downloadURL,
        'Name': nameController.text,
        'Detail': detailController.text,
        'info': infoController.text,
        'status': false,
      });

      // Reset fields
      setState(() {
        _selectedImage = null;
        nameController.clear();
        detailController.clear();
        infoController.clear();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField(
            //   controller: imageController,
            //   decoration: InputDecoration(labelText: 'ข้อความ'),
            // ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select image'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: detailController,
              decoration: const InputDecoration(labelText: 'Detail'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: infoController,
              decoration: const InputDecoration(labelText: 'info'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 20.0),

            MyDropdownButtonFormField(
                value: selectedCollection,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedCollection = value;
                    });
                  }
                }),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _uploadImageAndSaveData,
              child: Text('บันทึกข้อมูล'),
            ),

            SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(selectedCollection)
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
                          title: Center(child: Text(info['Name'])),
                          leading: Image.network(info['image']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Editbook(
                                        documentId: info.id,
                                        imageUrl: info['image'],
                                        name: info['Name'],
                                        detail: info['Detail'],
                                        info: info['info'],
                                        collection:
                                            selectedCollection, // ระบุ collection ที่ถูกเลือกจาก dropdown
                                      ),
                                    ),
                                  );
                                  // โค้ดสำหรับปุ่ม Update
                                  // สามารถเข้าถึงข้อมูลของรายการนี้ผ่านตัวแปร info
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
