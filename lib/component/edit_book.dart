import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Editbook extends StatefulWidget {
  final String documentId;
  final String imageUrl;
  final String name;
  final String detail;
  final String info;
  final String collection; // เพิ่มพารามิเตอร์ collection

  const Editbook({
    Key? key,
    required this.documentId,
    required this.imageUrl,
    required this.name,
    required this.detail,
    required this.info,
    required this.collection, // เพิ่มพารามิเตอร์ collection
  }) : super(key: key);

  @override
  _EditbookPageState createState() => _EditbookPageState();
}

class _EditbookPageState extends State<Editbook> {
  late TextEditingController _detailController;
  late TextEditingController _infoController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _detailController = TextEditingController(text: widget.detail);
    _infoController = TextEditingController(text: widget.info);
    _nameController = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _detailController.dispose();
    _infoController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> savedata() async {
    try {
      await Firebase.initializeApp();
      CollectionReference books = FirebaseFirestore.instance
          .collection(widget.collection); // ใช้ collection ที่ถูกส่งเข้ามา
      await books.doc(widget.documentId).update({
        'Detail': _detailController.text,
        'Name': _nameController.text,
        'info': _infoController.text,
      });

      // เมื่อเสร็จสิ้นและไม่เกิดข้อผิดพลาด
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data updated successfully')));
    } catch (e) {
      // เมื่อเกิดข้อผิดพลาด
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update data: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 160,
                height: 160,
                child: Image.network(widget.imageUrl),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _detailController,
                decoration: const InputDecoration(labelText: 'Detail'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _infoController,
                decoration: const InputDecoration(labelText: 'Info'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: savedata,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
