// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:developer';
import '/Helper/Firebase_DB.dart';
import '/Models/VehicleModel.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _searchQuery = "";
  List<String> _vehicles = [];

  @override
  void initState() {
    super.initState();
    fetchCommonNumberPlates();
  }

  fetchCommonNumberPlates() async {
    List<String> list = await FirebaseDBVehicle.db.getCommonNumberPlates();
    setState(() {
      _vehicles = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 22,
                      ),
                    )),
                Expanded(
                  flex: 8,
                  child: Container(
                      alignment: Alignment.center,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Container(
                            height: 63,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12))),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          hintText: 'Search',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 12),
                          border: InputBorder.none,
                          hintStyle: const TextStyle(color: Colors.blue),
                        ),
                        style: const TextStyle(color: Colors.black),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: ListView.builder(
              itemCount: _vehicles.length,
              itemBuilder: (BuildContext context, int index) {
                final vehicle = _vehicles[index];
                if (vehicle
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase())) {
                  return InkWell(
                    onTap: () async {
                      List<VehiclePolice> policeVehicles =
                          FirebaseDBVehicle.db.vehiclesOfPolice;
                      VehiclePolice? searchedVehicle =
                          policeVehicles.firstWhere(
                        (v) => v.number == vehicle,
                      );

                      if (searchedVehicle != null) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 140),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Divider(
                                            color: Colors.grey.shade400,
                                            thickness: 2.5,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15),
                                        child: Text(
                                          "Vehicle Details",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.white, width: 3)),
                                        child: Row(children: [
                                          const SizedBox(width: 15),
                                          const Text(
                                            'Number - ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            searchedVehicle.number,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ]),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.white, width: 3)),
                                        child: Row(children: [
                                          const SizedBox(width: 15),
                                          const Text(
                                            'Violence - ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            searchedVehicle.violence,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ]),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.white, width: 3)),
                                        child: Row(children: [
                                          const SizedBox(width: 15),
                                          const Text(
                                            'Model - ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            searchedVehicle.model,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ]),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          navigateTo(
                                              double.parse(
                                                  searchedVehicle.latitude),
                                              double.parse(
                                                  searchedVehicle.longitude));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.black38,
                                                  width: 1)),
                                          child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Open Map",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.location_on_sharp,
                                                  size: 22,
                                                  color: Colors.red,
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        log("Something went wrong");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.car_rental,
                                color: Colors.black54,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                vehicle,
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              )
                            ]),
                      ),
                    ),
                  );
                } else {
                  return const Text("Vehicle Not Found");
                }
              },
            ),
          )),
        ]),
      ),
    ));
  }

  static void navigateTo(double latitude, double longitude) async {
    var uri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
