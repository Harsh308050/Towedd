import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Helper/Firebase_DB.dart';
import 'Models/VehicleModel.dart';

class AddedVehicle extends StatefulWidget {
  const AddedVehicle({super.key});

  @override
  State<AddedVehicle> createState() => _AddedVehicleState();
}

class _AddedVehicleState extends State<AddedVehicle> {
  Query dbRef = FirebaseDatabase.instance.ref().child('vehicleData');
  List<bool> towList = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var width = size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("All Vehicles"),
        ),
        body: StreamBuilder(
          stream: FirebaseDBVehicle.refUser.onValue,
          builder: (context, AsyncSnapshot snap) {
            if (snap.hasError) {
              return Text("error :-- ${snap.error}");
            } else if (snap.hasData) {
              DatabaseEvent data = snap.data;
              List<VehicleUser> vehicles = [];

              final Map snapshotData = data.snapshot.value as Map;

              for (var entry in snapshotData.entries) {
                final vehicle = VehicleUser.fromJson(
                    {...entry.value, 'id': entry.key}, entry.key);
                vehicles.add(vehicle);
                towList.add(false);
              }
              if (vehicles.length != towList.length) {
                towList.removeRange(vehicles.length, towList.length);
              }

              return ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(color: Colors.blue, width: 3),
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Column(children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: width - 55,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    'Type - ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' ${vehicles[i].type}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ]),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                height: 45,
                                width: width - 55,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  const Text(
                                    'Company - ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' ${vehicles[i].company}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ]),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                height: 45,
                                width: width - 55,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  const Text(
                                    'Model - ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' ${vehicles[i].model}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ]),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                height: 45,
                                width: width - 55,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  const Text(
                                    'Number - ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' ${vehicles[i].number}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ]),
                              ),
                              SizedBox(
                                height: 8,
                              )
                            ]),
                          ],
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                          child: Divider(
                            color: Colors.black38,
                            thickness: 0.4,
                          ),
                        ),
                        if (towList[i])
                          GestureDetector(
                            onTap: () async {
                              await FirebaseDBVehicle.db
                                  .deleteUserVehicle(vehicles[i].id);
                            },
                            child: const Center(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Remove",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.remove_circle_outline_sharp,
                                      size: 22,
                                      color: Colors.red,
                                    )
                                  ]),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                towList[i] = !towList[i];
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  towList[i]
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Colors.blue,
                                ),
                                Text(
                                  towList[i] ? 'Hide' : 'Show More',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
