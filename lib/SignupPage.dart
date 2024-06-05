import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Helper/Authentication_helper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController conpassController = TextEditingController();
  bool _passwordVisible = true;
  bool isLoading = false;

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7ECEF);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Image.asset(
                  'assets/TowedLogo.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                )),
            Stack(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Positioned(
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 25),
                      child: const Text(
                        '_______________________________',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      )))
            ]),
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
                  height: height - 290,
                  width: width),
              Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 400,
                  left: MediaQuery.of(context).size.width / 3 - 140,
                  child: Container(
                      width: 150,
                      margin: const EdgeInsets.fromLTRB(120, 1, 100, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        color: Colors.blue,
                      ),
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text('SignUp',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          )))),
              Form(
                  key: _key,
                  child: Column(children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(15, 72, 15, 0),
                      child: TextFormField(
                        controller: emailController,
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
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                            hintText: 'Email'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(15, 22, 15, 0),
                      child: TextFormField(
                        obscureText: _passwordVisible,
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
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(15, 22, 15, 0),
                      child: TextFormField(
                        obscureText: _passwordVisible,
                        controller: conpassController,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Confirm Password Is Required Please Enter';
                          }
                          if (value != passwordController.text) {
                            return 'Confirm Password Not Matching';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                          hintText: 'Confirm Password',
                        ),
                        maxLength: 20,
                      ),
                    ),
                  ])),
              Positioned(
                  bottom: MediaQuery.of(context).size.height / 3 - 150,
                  left: MediaQuery.of(context).size.width / 3 - 15,
                  child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await Authentication_helper.firebase
                                    .registerwithEmailandPassword(
                                        emailController.text,
                                        conpassController.text);
                              } catch (e) {
                                ScaffoldMessenger(
                                  child: Text("SignUp Failed Try Again"),
                                );
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                              Navigator.of(context).pushNamed('UserHome');
                              _key.currentState!.reset();

                              passwordController.clear();
                              emailController.clear();
                              conpassController.clear();
                            }
                          }))),
              Positioned(
                  bottom: MediaQuery.of(context).size.height / 4 - 150,
                  left: MediaQuery.of(context).size.width / 6 - 10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('LoginUser');
                          },
                        )
                      ])),
              Positioned(
                  top: MediaQuery.of(context).size.height / 4 - 140,
                  left: MediaQuery.of(context).size.width / 3 - 75,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.blue,
                      ),
                      height: 20,
                      width: 80,
                      alignment: Alignment.center,
                      child: const Text('Email',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )))),
              Positioned(
                  top: MediaQuery.of(context).size.height / 4 - 55,
                  left: MediaQuery.of(context).size.width / 3 - 75,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.blue,
                      ),
                      height: 20,
                      width: 80,
                      alignment: Alignment.center,
                      child: const Text('Password',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )))),
              Positioned(
                  top: MediaQuery.of(context).size.height / 4 + 45,
                  left: MediaQuery.of(context).size.width / 3 - 75,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.blue,
                      ),
                      height: 20,
                      width: 120,
                      alignment: Alignment.center,
                      child: const Text('Confirm Password',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                  height: height - 10,
                  width: width - 10,
                  color: Colors.white.withOpacity(0.7),
                )),
              ),
            ])
          ])),
    );
  }
}
