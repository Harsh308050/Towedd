import 'dart:developer';
import 'package:flutter/material.dart';

import './Helper/Firebase_DB.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => AddVehicleState();
}

class AddVehicleState extends State<AddVehicle> {
  List<String> listItems = ["LMV", "MCWOG", "MCWG"];
  String vehicleType = "LMV";
  List<String> listItems1 = ["Petrol", "Diesel"];
  String fuelType = "Petrol";

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController vehicleCompanyController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Vehicle"),
      ),
      body: ListView(children: <Widget>[
        Image.asset(
          'assets/Add_Vehicle_Main.jpg',
          height: 188,
          width: 500,
        ),
        Container(
            width: width,
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: const Text('Add Your Vehicle',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent))),
        Container(
            width: width,
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: const Text('Enter Your Vehicle Details To Help You Better',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54))),
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(
              width: 50,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue,
                ),
                height: 20,
                width: width / 4,
                alignment: Alignment.center,
                child: const Text('Vehicle Type',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ))),
            const SizedBox(
              width: 90,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue,
                ),
                height: 20,
                width: width / 4.5,
                alignment: Alignment.center,
                child: const Text('Fuel Type',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )))
          ],
        ),
        const SizedBox(
          height: 1,
        ),
        Row(children: [
          const SizedBox(
            width: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2.5)),
            height: 55,
            width: 150,
            child: DropdownButton(
                iconSize: 30,
                iconEnabledColor: Colors.blue,
                alignment: Alignment.center,
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                borderRadius: BorderRadius.circular(12),
                dropdownColor: Colors.blue[100],
                value: vehicleType,
                onChanged: (value) {
                  setState(() {
                    vehicleType = value.toString();
                  });
                },
                isDense: true,
                isExpanded: true,
                items: listItems.map((itemOne) {
                  return DropdownMenuItem(value: itemOne, child: Text(itemOne));
                }).toList()),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2.5)),
            height: 55,
            width: 150,
            child: DropdownButton(
                iconSize: 30,
                iconEnabledColor: Colors.blue,
                alignment: Alignment.center,
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                borderRadius: BorderRadius.circular(12),
                dropdownColor: Colors.blue[100],
                value: fuelType,
                onChanged: (value1) {
                  setState(() {
                    fuelType = value1.toString();
                  });
                },
                isDense: true,
                isExpanded: true,
                items: listItems1.map((itemOne1) {
                  return DropdownMenuItem(
                      value: itemOne1, child: Text(itemOne1));
                }).toList()),
          ),
        ]),
        Form(
            key: _key,
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
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                  child: TextFormField(
                    controller: vehicleModelController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
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
                      labelText: 'Vehicle Model',
                      labelStyle: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                  child: TextFormField(
                    controller: vehicleNumberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
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
                      labelText: 'Vehicle Number',
                      labelStyle: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )),
        const SizedBox(
          height: 15,
        ),
        Container(
            alignment: Alignment.center,
            height: 70,
            child: ElevatedButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  try {
                    Map vehicleDataUser = {
                      "vehicle_type": vehicleType,
                      "fuel_type": fuelType,
                      "vehicle_company": vehicleCompanyController.text,
                      "vehicle_model": vehicleModelController.text,
                      "vehicle_number": vehicleNumberController.text,
                    };
                    await FirebaseDBVehicle.db
                        .insertUserVehicle(vehicleDataUser);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vehicle Uploaded Sucessfully")));
                    Navigator.of(context).pop();
                  } catch (e) {
                    log(e.toString());
                  }
                }
              },
              child: const Text(
                'Add Vehicle',
                style: TextStyle(fontSize: 20),
              ),
            ))
      ]),
    );
  }
}
