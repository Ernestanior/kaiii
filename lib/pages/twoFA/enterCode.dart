import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/user.dart';
import 'package:pinput/pinput.dart';

class Entercode extends StatefulWidget {
  const Entercode({super.key});

  @override
  State<Entercode> createState() => _EntercodeState();
}

class _EntercodeState extends State<Entercode> {
  String pins = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('6位验证码输入'),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'ENTERCODE'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    '6_DIGIT_SECURITY_CODE_TO_CONTINUE'.tr,
                    style: const TextStyle(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 129, 129, 129)),
                  ),
                  Container(
                    height: 40,
                  ),
                  Pinput(
                    length: 6,
                    onCompleted: (pin) async {
                      await verifyAuthCode(pin);
                      await UserInfo().getUserInfo();
                      Navigator.pushReplacementNamed(context, '/AuthSuccess');
                      // setState(() {
                      //   pins = pin;
                      // });
                    },
                  )
                ],
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       print(pins);
              //     },
              //     child: Text('NEXT'.tr))
            ],
          ),
        ));
  }
}
