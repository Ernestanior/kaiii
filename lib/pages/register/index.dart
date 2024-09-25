import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/common/utils.dart';
import 'package:kaino/network/api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username = '';
  String password = '';
  String confirmPwd = '';
  String errMsg = '';
  bool _obscureText = true;
  bool _confirmObscureText = true;

  onSubmit() async {
    Navigator.pushNamed(context, '/registerSuccess');
    // if (username == '' || password == '' || confirmPwd == '') {
    //   setState(() {
    //     errMsg = "USERNAME_OR_PASSWORD_CANNOT_BE_EMPTY".tr;
    //   });
    //   return;
    // }
    // if (!Utils().validateEmail(username)) {
    //   setState(() {
    //     errMsg = "PLEASE_ENTER_VALID_EMAIL".tr;
    //   });
    //   return;
    // }

    // RegExp exp = RegExp(
    //     r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@!%*#?&])[A-Za-z\d$@!%*#?&]{8,}$");
    // if (!exp.hasMatch(password)) {
    //   setState(() {
    //     errMsg = 'PASSWORD_COMPLEX_INFO'.tr;
    //   });
    //   return;
    // }
    // if (password != confirmPwd) {
    //   setState(() {
    //     errMsg = 'THE_TWO_PASSWORDS_YOU_ENTERED_DO_NOT_MATCH'.tr;
    //   });
    //   return;
    // }
    // dynamic res = await register({'username': username, 'password': password});
    // print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              width: 240,
              margin: const EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 300,
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          username = value.trim();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility))),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          confirmPwd = value;
                        });
                      },
                      obscureText: _confirmObscureText,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _confirmObscureText = !_confirmObscureText;
                                });
                              },
                              icon: Icon(_confirmObscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility))),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        errMsg,
                        style: const TextStyle(color: Colors.red, fontSize: 11),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () => onSubmit(),
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 113, 170, 216))),
                        child: Text('SIGN_UP'.tr),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('ALREADY_HAVE_AN_ACCOUNT'.tr),
                  const Text(' '),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'LOGIN_HERE'.tr,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
