// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RTODocumentPage extends StatefulWidget {
  const RTODocumentPage({
    super.key,
  });

  @override
  State<RTODocumentPage> createState() => RTODocumentPageState();
}

class RTODocumentPageState extends State<RTODocumentPage> {
  final ImagePicker _imagePicker = ImagePicker();
  List<File> _selectedImages = [];

  Future<void> _pickAndUploadImages() async {
    final pickedFiles = await _imagePicker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _selectedImages =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      });
      _uploadImagesToFirebase();
    }
  }

  Future<void> _uploadImagesToFirebase() async {
    for (var image in _selectedImages) {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('User Documents/${DateTime.now().microsecondsSinceEpoch}');
      final UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7ECEF);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("RTO Documents"),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    'assets/RTO_Documents.png',
                    height: 230,
                    width: 460,
                    fit: BoxFit.cover,
                  )),
              Container(
                  width: width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: const Text('Vehicle Documents',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent))),
              Container(
                  width: width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: const Text(
                      'Add Your Vehicle Documents To Help You Better',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey))),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                          onTap: _pickAndUploadImages,
                          child: Container(
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: height / 4.8,
                              width: width - 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/add_documents.png',
                                    height: 130,
                                    width: 400,
                                  ),
                                  const Text('Add Documents',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(
                                    height: 6,
                                  )
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('SeeDocumentPage');
                            },
                            child: Container(
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: height / 4.8,
                                width: width - 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/see_documents.png',
                                      height: 130,
                                      width: 300,
                                    ),
                                    const Text('See Documents',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 6,
                                    )
                                  ],
                                ))),
                      ),
                    ]),
              ),
            ])));
  }
}
