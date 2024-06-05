import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ViewProfilePolicePage extends StatefulWidget {
  const ViewProfilePolicePage({super.key});

  @override
  State<ViewProfilePolicePage> createState() => _ViewProfilePolicePageState();
}

class _ViewProfilePolicePageState extends State<ViewProfilePolicePage> {
  TextEditingController PoliceIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController state = TextEditingController();

  String? PoliceID;
  String? password;

  int id = 0;

  PlatformFile? pickedFile;

  Future uploadFile() async {
    final path = 'ProfilePic/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7ECEF);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Center(
                                  child: Text(
                                    'Are You Sure Want To Logout ?',
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                    child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('LoginUser');
                                        },
                                        child: const Text(
                                          "Logout",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            )
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(
              0,
              10,
              0,
              0,
            ),
            child: Column(children: [
              Center(
                  child: Stack(children: <Widget>[
                Stack(children: [
                  (pickedFile == null)
                      ? Container(
                          height: 150,
                          width: 150,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                  fit: BoxFit.cover,
                                  "assets/policeofficer.png")))
                      : Container(
                          height: 150,
                          width: 150,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.file(
                                  fit: BoxFit.cover, File(pickedFile!.path!)))),
                  Positioned(
                    top: 120,
                    left: 100,
                    child: InkWell(
                      onTap: selectFile,
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue[900],
                        size: 35,
                      ),
                    ),
                  ),
                ]),
              ])),
              const SizedBox(
                height: 25,
              ),
              Container(
                  alignment: Alignment.center,
                  width: width / 2,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue),
                  child: const Center(
                    child: Text(
                      "View Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                  )),
              const SizedBox(
                height: 25,
              ),
              Stack(children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(2, 0, 2, 10),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: height / 2.5 - 40,
                    width: width),
                Positioned(
                  top: MediaQuery.of(context).size.height / 20 + 10,
                  left: MediaQuery.of(context).size.width - 400,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: width / 2 + 185,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white,
                    ),
                    child:
                        Text('$password', style: const TextStyle(fontSize: 12)),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 20 + 110,
                  left: MediaQuery.of(context).size.width - 400,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: width / 2 + 185,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white,
                    ),
                    child:
                        Text('$PoliceID', style: const TextStyle(fontSize: 12)),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 20,
                  left: MediaQuery.of(context).size.width / 8.5,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.blue,
                      ),
                      height: 20,
                      width: width / 5,
                      alignment: Alignment.center,
                      child: const Text('Police ID',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height / 20 + 105,
                    left: MediaQuery.of(context).size.width / 8.5,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.blue,
                        ),
                        height: 20,
                        width: width / 4.5,
                        alignment: Alignment.center,
                        child: const Text('Password',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )))),
              ]),
            ])));
  }
}
