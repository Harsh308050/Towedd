import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import '/Models/VehicleModel.dart';

class FirebaseDBVehicle {
  FirebaseDBVehicle._();
  static final FirebaseDBVehicle db = FirebaseDBVehicle._();
  static final FirebaseDatabase database = FirebaseDatabase.instance;
  static final DatabaseReference refUser = database.ref("vehicleDataUser");
  List<VehicleUser> vehiclesOfUsers = [];

  List<String> numberPlates = [];
  insertUserVehicle(Map data) async {
    await refUser.push().set(data);
  }

  updateUserVehicle(Map<String, dynamic> data, String key) async {
    await refUser.child(key).update(data);
  }

  deleteUserVehicle(String key) async {
    await refUser.child(key).remove();
  }

  listOfUserVehicles() async {
    try {
      DatabaseEvent event = await refUser.once();
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        VehicleUser vehicleUser = VehicleUser.fromJson(convertMap(value), key);
        vehiclesOfUsers.add(vehicleUser);
        print("List of user vehicles :-- $vehiclesOfUsers");
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  static final DatabaseReference refPolice = database.ref("vehicleDataPolice");
  List<VehiclePolice> vehiclesOfPolice = [];
  insertPoliceVehicle(Map data) async {
    await refPolice.push().set(data);
  }

  updatePoliceVehicle(Map<String, dynamic> data, String key) async {
    await refPolice.child(key).update(data);
  }

  deletePoliceVehicle(String key) async {
    await refPolice.child(key).remove();
  }

  listOfPoliceVehicles() async {
    try {
      DatabaseEvent event = await refPolice.once();
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        VehiclePolice vehiclePolice =
            VehiclePolice.fromJson(convertMap(value), key);
        vehiclesOfPolice.add(vehiclePolice);
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  static final DatabaseReference refPoliceId = database.ref("PoliceId");
  List<Police> IdOfPolice = [];
  insertPolice(Map data) async {
    await refPolice.push().set(data);
  }

  updatePolice(Map<String, dynamic> data, String key) async {
    await refPolice.child(key).update(data);
  }

  deletePolice(String key) async {
    await refPolice.child(key).remove();
  }

  listOfPolice() async {
    try {
      DatabaseEvent event = await refPolice.once();
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        Police Policeid = Police.fromJson(convertMap(value), key);
        IdOfPolice.add(Policeid);
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  getCommonNumberPlates() async {
    await listOfUserVehicles();
    await listOfPoliceVehicles();
    numberPlates = getCommonNumbers(vehiclesOfUsers, vehiclesOfPolice);
    return numberPlates;
  }

  // fetchDataByNumberPlate(String numberPlate, String id) async {
  //   try {
  //     print(id);
  //     final DatabaseReference databaseReference = refPolice.child(id);

  //     Query query =
  //         databaseReference.orderByChild('vehicle_number').equalTo(numberPlate);
  //     DatabaseEvent snapshot = await query.once();

  //     if (snapshot.snapshot.value != null) {
  //       Map<dynamic, dynamic> data =
  //           snapshot.snapshot.value as Map<dynamic, dynamic>;
  //       print("Fetch Data: $data");
  //     } else {
  //       print("No data found for number plate: $numberPlate");
  //     }
  //   } catch (e) {
  //     log("fetchDataByNumberPlate exception :-- $e");
  //   }
  // }
}

Map<String, dynamic> convertMap(Map<Object?, Object?> originalMap) {
  Map<String, dynamic> convertedMap = {};

  originalMap.forEach((key, value) {
    if (key is String) {
      convertedMap[key] = value;
    }
  });

  return convertedMap;
}

List<String> getCommonNumbers(
    List<VehicleUser> vehicleUser, List<VehiclePolice> vehiclePolice) {
  Set<String> userNumbers = vehicleUser.map((user) {
    log(user.number);
    return user.number;
  }).toSet();
  Set<String> policeNumbers =
      vehiclePolice.map((police) => police.number).toSet();

  print("User numbers :-- $userNumbers ,,, Police numbers :-- $policeNumbers");

  // Set<String> userNumberPlates = userNumbers.map((user) => user.number).toSet();

  // Set<VehiclePolice> commonPoliceVehicles = policeNumbers
  //     .where((police) => userNumberPlates.contains(police.number))
  //     .toSet();

  // Set<VehiclePolice> finalVehicles =
  //     removeDuplicateNumberVehicles(commonPoliceVehicles);
  // log(finalVehicles.toList().length.toString());
  // return finalVehicles.toList();

  List<String> commonNumbers = userNumbers.intersection(policeNumbers).toList();

  log("common numbers :-- ${commonNumbers.length}");

  return commonNumbers;
}

// removeDuplicateNumberVehicles(Set<VehiclePolice> policeNumbers) {
//   Set<String> numberSet = {};

//   policeNumbers.removeWhere((police) {
//     if (numberSet.contains(police.number)) {
//       return true; // Remove the element
//     } else {
//       numberSet.add(police.number);
//       return false; // Keep the element
//     }
//   });
//   return policeNumbers;
// }

class FirebaseDBPolice {
  FirebaseDBPolice._();
  static final FirebaseDBPolice db = FirebaseDBPolice._();
  static final FirebaseDatabase database = FirebaseDatabase.instance;
  static final DatabaseReference refPoliceid = database.ref("PoliceData");
  List<Police> PoliceId = [];

  insertPolice(Map data) async {
    await refPoliceid.push().set(data);
  }

  updatePolice(Map<String, dynamic> data, String key) async {
    await refPoliceid.child(key).update(data);
  }

  deletePolice(String key) async {
    await refPoliceid.child(key).remove();
  }

  Future<List<Police>> listOfPolice() async {
    try {
      DatabaseEvent event = await refPoliceid.once();
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
      List<Police> PoliceId = [];
      data.forEach((key, value) {
        Police police = Police.fromJson(convertMap(value), key);
        PoliceId.add(police);
      });
      return PoliceId;
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}
