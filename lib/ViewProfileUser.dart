import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPageUser.dart';

class ViewProfileUserPage extends StatefulWidget {
  const ViewProfileUserPage({super.key});

  @override
  State<ViewProfileUserPage> createState() => _ViewProfileUserPageState();
}

class _ViewProfileUserPageState extends State<ViewProfileUserPage> {
  TextEditingController state = TextEditingController();

  int id = 0;

  XFile? _image;

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = selectedImage;
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
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
                                      width: 100,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _logout(context);
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
                  (_image == null)
                      ? Container(
                          height: 150,
                          width: 150,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                  fit: BoxFit.cover, "assets/ProfilePic.jpg")))
                      : Container(
                          height: 150,
                          width: 150,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.file(
                                  fit: BoxFit.cover, File(_image!.path)))),
                  Positioned(
                    top: 120,
                    left: 100,
                    child: InkWell(
                      onTap: _selectImage,
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
                  left: MediaQuery.of(context).size.width - 345,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: width / 2 + 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white,
                    ),
                    child: Text(_currentUser?.email ?? 'null',
                        style: const TextStyle(fontSize: 12)),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 20 + 110,
                  left: MediaQuery.of(context).size.width - 345,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: width / 2 + 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white,
                    ),
                    child: Text('null', style: const TextStyle(fontSize: 12)),
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
                      child: const Text('Email ID',
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

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPageUser()),
      );
    } catch (e) {
      print('Error occurred while logging out: $e');
    }
  }
}
