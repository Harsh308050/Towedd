import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import 'Models/VehicleModel.dart';

class PoliceHome extends StatefulWidget {
  const PoliceHome({super.key});

  @override
  State<PoliceHome> createState() => PoliceHomeState();
}

class PoliceHomeState extends State<PoliceHome> {
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

  @override
  Widget build(BuildContext context) {
    Police? police = ModalRoute.of(context)!.settings.arguments as Police?;
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
                                        "assets/policeofficer.jpg")))
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
                          left: width / 4 + 20,
                          child: Text(
                            police!.PoliceID,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]))),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile Picture"),
              onTap: _selectImage,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
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
                                fit: BoxFit.cover, "assets/policeofficer.jpg")))
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
              left: width / 2 - 30,
              child: Text(
                police.PoliceID,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Ink(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('UploadVehiclePolice');
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
                              height: height / 5,
                              width: width / 3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/Upload_Vehicle.png',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: const Text(
                                        '____________________',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  const Text('Upload Vehicle',
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
                                    .pushNamed('AllVehiclePolice');
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
                                  height: height / 5,
                                  width: width / 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/all_vehicle.png',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 5, 0),
                                          child: const Text(
                                            '____________________',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      const Text('All Vehicle',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 6)
                                    ],
                                  ))))),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Ink(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('GenerateReceipt');
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
                        height: height / 5,
                        width: width / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Generate_Receipt.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: const Text(
                                  '____________________',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                            const Text('Generate Receipt',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6)
                          ],
                        )))),
          )
        ]),
      ),
    );
  }
}
