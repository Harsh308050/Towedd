import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'Helper/Firebase_DB.dart';
import 'Models/VehicleModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class PayPenaltyPage extends StatefulWidget {
  const PayPenaltyPage({super.key});

  @override
  State<PayPenaltyPage> createState() => PayPenaltyPageState();
}

class PayPenaltyPageState extends State<PayPenaltyPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      Fluttertoast.showToast(
        msg: "Successful payment",
      );
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      Fluttertoast.showToast(
        msg: "Not successful payment",
      );
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      log("EXTERNAL WALLET :--------------------- ${response.walletName}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(int amount, String description, String orderId,
      String mobileNumber, String name, String email) async {
    log("open checkout");
    var options = {
      'key': "rzp_test_RxuQ6yNNP5sEKK",
      'amount': amount,
      'name': name,
      'description': description,
      'order_id': orderId,
      'prefill': {'contact': mobileNumber, 'email': email},
      'external': {
        'wallets': ['paytm', 'phonepe']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  createOrderId(int amount) async {
    log("enter");
    var uuid = const Uuid();

    String receiptPortion = uuid.v4();
    log(receiptPortion);
    log(receiptPortion.length.toString());

    final uri = Uri.parse(
      "https://api.razorpay.com/v1/orders",
    );

    http.Response response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic ${base64Encode(utf8.encode('rzp_test_RxuQ6yNNP5sEKK:0bOa3565PMWKggyKFuhNs35D'))} "
        },
        body: json.encode({
          "amount": amount * 100,
          "currency": "INR",
          "receipt": "Id$receiptPortion",
        }));
    log(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      openCheckout(amount * 100, '...', data["id"], "9090909090",
          " ${_currentUser?.email}", "email@gmail.com");
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Pay Penalty"),
        ),
        body: StreamBuilder(
          stream: FirebaseDBVehicle.refPolice.onValue,
          builder: (context, AsyncSnapshot snap) {
            if (snap.hasError) {
              return Text("error :-- ${snap.error}");
            } else if (snap.hasData) {
              DatabaseEvent data = snap.data;
              List<VehiclePolice> vehicles = [];

              final Map snapshotData = data.snapshot.value as Map;
              for (var entry in snapshotData.entries) {
                final vehicle = VehiclePolice.fromJson(
                    {...entry.value, 'id': entry.key}, "");
                vehicles.add(vehicle);
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
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Column(children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: width - 55,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Row(children: [
                                  const SizedBox(
                                    width: 15,
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
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Row(children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  const Text(
                                    'Violence - ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' ${vehicles[i].violence}',
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
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Row(children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  const Text(
                                    'Amount - ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' ${vehicles[i].penalty}',
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
                            ]),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            createOrderId(int.parse(vehicles[i].penalty));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.blue, width: 3)),
                            child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Pay",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.monetization_on,
                                    size: 25,
                                    color: Colors.blue,
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
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
        ));
  }
}
