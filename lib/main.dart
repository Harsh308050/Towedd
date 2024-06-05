import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'AddedVehicle.dart';
import 'SeeDocumentsPage.dart';
import 'SignupPage.dart';
import 'LoginPageUser.dart';
import 'LoginPagePolice.dart';
import 'UserHome.dart';
import 'PoliceHome.dart';
import 'RTODocumentPage.dart';
import 'AddVehicle.dart';
import 'ViewProfilePolice.dart';
import 'ViewProfileUser.dart';
import 'PayPenaltyPage.dart';
import 'VehiclePage.dart';
import 'RTOExamPage.dart';
import 'UploadVehiclePolice.dart';
import 'AllVehiclePolice.dart';
import 'Search.dart';
import 'GenerateReceipt.dart';
import 'AuthenticationChecker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'AuthCheck',
    routes: {
      'AuthCheck': (context) => AuthenticationChecker(),
      'Signup': (context) => const SignupPage(),
      'LoginUser': (context) => const LoginPageUser(),
      'LoginPolice': (context) => const LoginPagePolice(),
      'PoliceHome': (context) => const PoliceHome(),
      'RTODocument': (context) => const RTODocumentPage(),
      'UserViewProfile': (context) => const ViewProfileUserPage(),
      'PoliceViewProfile': (context) => const ViewProfilePolicePage(),
      'UserHome': (context) => const UserHome(),
      'AddVehicle': (context) => const AddVehicle(),
      'PayPenaltyPage': (context) => const PayPenaltyPage(),
      'VehiclePage': (context) => const VehiclePage(),
      'SeeDocumentPage': (context) => SeeDocumentsPage(),
      'RTOQuestionsPage': (context) => const RTOQuestionsPage(),
      'UploadVehiclePolice': (context) => const UploadVehiclePolice(),
      'AllVehiclePolice': (context) => const AllVehiclePolice(),
      'AddedVehicle': (context) => const AddedVehicle(),
      'Search': (context) => const SearchPage(),
      'GenerateReceipt': ((context) => const GenerateReceipt())
    },
  ));
}
