// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Helper/Firebase_DB.dart';

class UploadVehiclePolice extends StatefulWidget {
  const UploadVehiclePolice({super.key});

  @override
  State<UploadVehiclePolice> createState() => UploadVehiclePoliceState();
}

class UploadVehiclePoliceState extends State<UploadVehiclePolice> {
  List<String> listItems = ["LMV", "MCWOG", "MCWG"];
  String selectVal = "LMV";
  List<String> listItems1 = ["Petrol", "Diesel"];
  String selectValue1 = "Petrol";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  double latitude = 0;
  double longitude = 0;
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController vehicleCompanyController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController violenceController = TextEditingController();
  TextEditingController penaltyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7ECEF);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Upload Vehicle"),
      ),
      body: Column(children: [
        Expanded(
          flex: 4,
          child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      child: TextFormField(
                        controller: vehicleCompanyController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          labelText: 'Vehicle Company',
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      child: TextFormField(
                        controller: vehicleModelController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          labelText: 'Vehicle Model',
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      child: TextFormField(
                        controller: vehicleNumberController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          labelText: 'Vehicle Number',
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      child: TextFormField(
                        controller: violenceController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          labelText: 'Violence',
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      child: TextFormField(
                        controller: penaltyController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          labelText: 'Penalty Amount',
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      child: TextFormField(
                        readOnly: true,
                        controller: latitudeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onTap: () async {
                          PermissionStatus status =
                              await Permission.locationWhenInUse.request();
                          if (status.isGranted) {
                            Geolocator.getPositionStream()
                                .listen((Position position) {
                              latitudeController.text =
                                  "${position.latitude.toStringAsFixed(8)}";
                            });
                          } else if (status.isDenied) {
                            PermissionStatus status1 =
                                await Permission.locationWhenInUse.request();
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          labelText: 'Latitude',
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      child: TextFormField(
                        readOnly: true,
                        controller: longitudeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onTap: () async {
                          PermissionStatus status =
                              await Permission.locationWhenInUse.request();
                          if (status.isGranted) {
                            Geolocator.getPositionStream()
                                .listen((Position position) {
                              longitudeController.text =
                                  "${position.longitude.toStringAsFixed(8)}";
                            });
                          } else if (status.isDenied) {
                            PermissionStatus status1 =
                                await Permission.locationWhenInUse.request();
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blueAccent)),
                          labelText: 'Longitude',
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        Container(
            alignment: Alignment.center,
            height: 70,
            child: ElevatedButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  try {
                    Map vehicleDataPolice = {
                      "vehicle_company": vehicleCompanyController.text,
                      "vehicle_model": vehicleModelController.text,
                      "vehicle_number": vehicleNumberController.text,
                      "violence": violenceController.text,
                      "penalty": penaltyController.text,
                      "latitude": latitudeController.text,
                      "longitude": longitudeController.text,
                    };
                    await FirebaseDBVehicle.db
                        .insertPoliceVehicle(vehicleDataPolice);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vehicle Uploaded Sucessfully")));
                    Navigator.of(context).pop();
                  } catch (e) {
                    log(e.toString());
                  }
                }
              },
              child: const Text(
                'Upload Vehicle',
                style: TextStyle(fontSize: 20),
              ),
            ))
      ]),
    );
  }
}
