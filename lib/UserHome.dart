import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => UserHomeState();
}

class UserHomeState extends State<UserHome> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
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

    return SafeArea(
      child: Scaffold(
        key: drawerKey,
        drawer: Drawer(
            child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: DrawerHeader(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue,
                      ),
                      child: Stack(children: <Widget>[
                        (_image == null)
                            ? Container(
                                margin: EdgeInsets.only(top: 20, left: 85),
                                height: 90,
                                width: 90,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.asset(
                                        fit: BoxFit.cover,
                                        "assets/ProfilePic.jpg")))
                            : Container(
                                margin: EdgeInsets.only(top: 20, left: 85),
                                height: 90,
                                width: 90,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.file(io.File(_image!.path),
                                      fit: BoxFit.cover),
                                )),
                        Positioned(
                          top: 125,
                          left: 45,
                          child: Text(
                            _currentUser?.email ?? "null",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]))),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Profile Picture"),
              onTap: _selectImage,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
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
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.dangerous_sharp,
                                        color: Colors.red.shade400,
                                        size: 26,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Confirmation',
                                        style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black38,
                                  thickness: 0.6,
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
        )),
        backgroundColor: backgroundColor,
        body: Column(children: [
          Stack(children: [
            Container(
              height: 270,
              width: 700,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Colors.blueAccent,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 8 - 65,
              left: MediaQuery.of(context).size.width / 6 + 40,
              child: Container(
                  child: Center(
                      child: Stack(children: <Widget>[
                (_image == null)
                    ? Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                                fit: BoxFit.cover, "assets/ProfilePic.jpg")))
                    : Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.file(io.File(_image!.path),
                              fit: BoxFit.cover),
                        )),
              ]))),
            ),
            Positioned(
              top: 5,
              left: width - 60,
              child: Container(
                  child: IconButton(
                onPressed: () {
                  drawerKey.currentState?.openDrawer();
                },
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              )),
            ),
            Positioned(
              top: height / 4 + 10,
              left: 80,
              child: Text(
                _currentUser?.email ?? 'null',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('Search');
            },
            child: Container(
              alignment: Alignment.centerRight,
              height: 65,
              width: width / 2 + 150,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 205,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 55,
                        child: Center(
                            child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
              child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Ink(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('VehiclePage');
                                        },
                                        child: Container(
                                            alignment: Alignment.topLeft,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.blue,
                                                width: 3.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: height / 5.2,
                                            width: width / 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Image.asset(
                                                  'assets/add_vehicle.png',
                                                  height: 100,
                                                  width: 120,
                                                ),
                                                Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: const Text(
                                                      '_______________________',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                const Text('Vehicles',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                const SizedBox(height: 6)
                                              ],
                                            )))),
                                Positioned(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('PayPenaltyPage');
                                        },
                                        child: Container(
                                            alignment: Alignment.topLeft,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.blue,
                                                width: 3.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: height / 5,
                                            width: width / 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Image.asset(
                                                  'assets/pay_penalty.png',
                                                  height: 100,
                                                  width: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                                Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: const Text(
                                                      '_______________________',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                const Text('Penalty',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 6)
                                              ],
                                            )))),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Ink(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('RTOQuestionsPage');
                                      },
                                      child: Container(
                                          alignment: Alignment.topLeft,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: 3.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          height: height / 5.2,
                                          width: width / 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/VehicleQuestions.png',
                                                height: 100,
                                                width: 120,
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 5, 0),
                                                  child: const Text(
                                                    '_______________________',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const Text('RTO Questions',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              const SizedBox(height: 6)
                                            ],
                                          )))),
                              Positioned(
                                  child: Ink(
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('RTODocument');
                                          },
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.blue,
                                                  width: 3.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              height: height / 5,
                                              width: width / 3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Image.asset(
                                                    'assets/RTO_Documents_Logo.png',
                                                    height: 100,
                                                    width: 120,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: const Text(
                                                        '_______________________',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                  const Text('RTO Documents',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const SizedBox(height: 6)
                                                ],
                                              ))))),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ])))
        ]),
      ),
    );
  }
}
