// ignore_for_file: dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Helper/Authentication_helper.dart';

class LoginPageUser extends StatefulWidget {
  const LoginPageUser({super.key});

  @override
  State<LoginPageUser> createState() => _LoginPageUserState();
}

class _LoginPageUserState extends State<LoginPageUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;
  bool isLoading = false;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7ECEF);

    bool isPressed = true;
    Offset distance = isPressed ? const Offset(10, 10) : const Offset(16, 16);
    double blur = isPressed ? 5.0 : 30.0;

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: const Text(
                      'Choose Account Type',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: const Text(
                      '__________________________________',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ))
              ]),
              const SizedBox(
                height: 15,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: blur,
                                    offset: -distance,
                                    color: Colors.white,
                                    inset: isPressed),
                                BoxShadow(
                                  blurRadius: blur,
                                  offset: distance,
                                  color: const Color(0xFFA7A9AF),
                                  inset: isPressed,
                                ),
                              ],
                              border: Border.all(
                                color: Colors.blue,
                                width: 7.0,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: height / 4.2,
                            width: width / 2.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(height: 4),
                                Image.asset(
                                  'assets/person.png',
                                  height: 140,
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                                const Text('User',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(height: 6)
                              ],
                            ))),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                          Navigator.of(context).pushNamed('LoginPolice');
                        },
                        child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  inset: isPressed,
                                  blurRadius: blur,
                                  offset: -distance,
                                  color: const Color(0xFFA7A9AF),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.blue,
                                width: 4.0,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: height / 4.2,
                            width: width / 2.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(height: 4),
                                Image.asset(
                                  'assets/policeofficer.png',
                                  height: 140,
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                                const Text('Police Officer',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6)
                              ],
                            ))),
                  ]),
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: const Text(
                      'Hello, Please Fill The Below Details To Get Started',
                      style: TextStyle(fontSize: 16, color: Colors.black87))),
              Stack(children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(2, 0, 2, 10),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: height / 2.43,
                    width: width),
                Form(
                    key: _key,
                    child: Column(children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(12, 50, 12, 0),
                        child: TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!);
                            if (val.isEmpty) {
                              return "Required";
                            } else if (!emailValid) {
                              return "Invalid";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 20,
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                        ),
                      )
                    ])),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(12, 135, 12, 0),
                  child: TextFormField(
                    obscureText: _passwordVisible,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    validator: (val) {
                      bool pwValid = RegExp(
                              r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                          .hasMatch(val!);
                      if (val.isEmpty) {
                        return "Required";
                      } else if (val.length < 8) {
                        return "Length must be at least 8 character long";
                      } else if (!pwValid) {
                        return "Password must be contain minimum 1 upper case, minimum 1 lower case, minimum 1 numeric, minimum 1 special character";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _passwordVisible = !_passwordVisible;
                            },
                          );
                        },
                      ),
                      border: const OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                    maxLength: 20,
                  ),
                ),
                Positioned(
                    left: MediaQuery.of(context).size.width / 3,
                    bottom: MediaQuery.of(context).size.height / 13,
                    child: Container(
                        alignment: Alignment.center,
                        height: height / 9,
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          child: const Text('Login',
                              style: TextStyle(fontSize: 20)),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              User? user = await Authentication_helper.firebase
                                  .loginwithEmailandPassword(
                                      emailController.text,
                                      passwordController.text);

                              if (user != null) {
                                setState(() {
                                  isLoading = false;
                                });

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "UserHome", (route) => false);
                                _key.currentState!.reset();
                                passwordController.clear();
                                emailController.clear();
                                _key.currentState!.save();
                              } else {
                                setState(() {
                                  isLoading = false;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Invalid Email or Password")));
                              }
                            }
                          },
                        ))),
                Positioned(
                    bottom: MediaQuery.of(context).size.height / 28,
                    left: MediaQuery.of(context).size.width / 5.5,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Don't have account?",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('Signup');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        ])),
                Positioned(
                  top: MediaQuery.of(context).size.height / 19,
                  left: MediaQuery.of(context).size.width / 8.5,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.blue,
                      ),
                      height: 20,
                      width: width / 5,
                      alignment: Alignment.center,
                      child: const Text('Email ID',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height / 19 + 85,
                    left: MediaQuery.of(context).size.width / 8.5,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.blue,
                        ),
                        height: 20,
                        width: width / 4.5,
                        alignment: Alignment.center,
                        child: const Text('Password',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )))),
                Positioned(
                    bottom: MediaQuery.of(context).size.height / 3 + 40,
                    right: MediaQuery.of(context).size.width / 3 - 100,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(110, 1, 90, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.0),
                          color: Colors.blue,
                        ),
                        height: 35,
                        width: width / 3,
                        alignment: Alignment.center,
                        child: const Text('Login',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            )))),
                Visibility(
                  visible: isLoading,
                  child: Center(
                      child: Container(
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    ),
                    height: height / 4 + 200,
                    color: Colors.white.withOpacity(0.8),
                  )),
                ),
              ]),
            ])));
  }
}
