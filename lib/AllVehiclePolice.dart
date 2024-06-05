import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Helper/Firebase_DB.dart';
import 'Models/VehicleModel.dart';

class AllVehiclePolice extends StatefulWidget {
  const AllVehiclePolice({Key? key}) : super(key: key);

  @override
  State<AllVehiclePolice> createState() => _AllVehiclePoliceState();
}

class _AllVehiclePoliceState extends State<AllVehiclePolice> {
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: StreamBuilder(
          stream: FirebaseDBVehicle.refPolice.onValue,
          builder: (context, AsyncSnapshot snap) {
            if (snap.hasError) {
              return Text("error :-- ${snap.error}");
            } else if (snap.hasData) {
              DatabaseEvent data = snap.data!;
              List<VehiclePolice> vehicles = [];

              final Map snapshotData = data.snapshot.value as Map;
              for (var entry in snapshotData.entries) {
                final vehicle = VehiclePolice.fromJson(
                    {...entry.value, 'id': entry.key}, "");
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
                    width: width - 30,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: width - 55,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text(
                                        'Number: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        ' ${vehicles[i].number}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  height: 45,
                                  width: width - 55,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      const Text(
                                        'Violence: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        ' ${vehicles[i].violence}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                if (towList[i]) ...[
                                  Container(
                                    height: 45,
                                    width: width - 55,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        const Text(
                                          'Amount:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          ' ${vehicles[i].penalty}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 45,
                                    width: width - 55,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(height: 8),
                                        const SizedBox(width: 18),
                                        const Text(
                                          'Latitude:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          ' ${vehicles[i].latitude}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 45,
                                    width: width - 55,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(height: 8),
                                        const SizedBox(width: 18),
                                        const Text(
                                          'Longitude:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          ' ${vehicles[i].longitude}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              towList[i] = !towList[i];
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                towList[i]
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                towList[i] ? 'Hide' : 'Show More',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
