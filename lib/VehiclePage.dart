import 'package:flutter/material.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({
    super.key,
  });

  @override
  State<VehiclePage> createState() => VehiclePageState();
}

class VehiclePageState extends State<VehiclePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Vehicle"),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    'assets/Vehicle.jpg',
                    height: 230,
                    width: 460,
                    fit: BoxFit.cover,
                  )),
              Container(
                  width: width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: const Text('Your Vehicles',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent))),
              Container(
                  width: width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: const Text('Add Your Vehicle To Help You Better',
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
                          onTap: () {
                            Navigator.of(context).pushNamed('AddVehicle');
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
                                    'assets/add_car.png',
                                    height: 120,
                                    width: 400,
                                  ),
                                  const Text('Add Vehicle',
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
                              Navigator.of(context).pushNamed('AddedVehicle');
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
                                      'assets/your_vehicles.png',
                                      height: 120,
                                      width: 300,
                                    ),
                                    const Text('Added Vehicles',
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
