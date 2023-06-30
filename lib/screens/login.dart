//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaarekatkm/providers/aoth.dart';
import 'package:shaarekatkm/screens/home.dart';
import 'package:shaarekatkm/screens/swetcheUserOrOrg.dart';

import '../models/http_excption.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() {
    return _LoginState();
  }

  static const routeName = '/Login';
}

class _LoginState extends State<Login> {
  //final auth = FirebaseAuth.instance;
  String user;
  String email;

  String password;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading;
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    
    try {
     await Provider.of<Auth>(context, listen: false)
            .login(email, password);
      // user = await auth
      //   .signInWithEmailAndPassword(email: email, password: password)
      //   .toString();
    if (user != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, Home.routeName, (route) => false);
    }
    } on HttpException catch (error) {
      var errorMessage = 'Authentcation failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address.';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again leter.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('okay!'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            margin: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/image/logo.png',
                  width: 200,
                  height: 200,
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        const Text(
                          'تسجيل دخول',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 35),
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'البريد الالكتروني',
                              counterStyle: TextStyle(color: Colors.blue),
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              )),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val.isEmpty ||
                                !val.contains('@') ||
                                !val.contains('.')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            email = val;
                          },
                          style:
                              const TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          decoration: const InputDecoration(
                              labelText: 'كلمة المرور',
                              counterStyle: TextStyle(color: Colors.blue),
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              )),
                          keyboardType: TextInputType.text,
                          style:
                              const TextStyle(fontSize: 20, color: Colors.blue),
                          validator: (val) {
                            if (val.isEmpty || val.length < 8) {
                              return 'password is too short!';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: _submit,
                              // () async {
                              //   try {
                              //     var user =
                              //         await auth.signInWithEmailAndPassword(
                              //             email: email, password: password);
                              //     if (user != null) {
                              //       Navigator.pushNamedAndRemoveUntil(context,
                              //           Home.routeName, (route) => false);
                              //     }
                              //   } catch (e) {
                              //     print(e);
                              //   }
                              // },
                              child: const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(SwetchUOrO.routeName),
                          child: const Text(
                            'انشاء حساب جديد',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
