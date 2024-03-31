import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditInfoPage extends StatefulWidget {
  final DocumentSnapshot info;

  const EditInfoPage({Key? key, required this.info}) : super(key: key);

  @override
  _EditInfoPageState createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.info['text']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(labelText: 'ข้อความ'),
              keyboardType:
                  TextInputType.multiline, 
              maxLines: null, 
              textInputAction:
                  TextInputAction.newline,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('information')
                      .doc(widget.info.id)
                      .update({'text': _textEditingController.text});

                  Navigator.pop(context); // ย้อนกลับไปยังหน้าก่อนหน้า
                } catch (error) {
                  print(error);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('มีข้อผิดพลาด: $error')),
                  );
                }
              },
              child: Text('ยืนยันการแก้ไข'),
            ),
          ],
        ),
      ),
    );
  }
}