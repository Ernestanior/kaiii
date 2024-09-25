import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/pages/home/index.dart';
import 'package:kaino/store/token.dart';
import 'package:kaino/store/user.dart';
import 'package:pinput/pinput.dart';

class Varification extends StatefulWidget {
  final Map<String, dynamic> arguments;
  const Varification({super.key, required this.arguments});

  @override
  State<Varification> createState() => _VarificationState();
}

class _VarificationState extends State<Varification> {
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
                    'Varification'.tr,
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
                      String token = await verifyAuthCode(pin,
                          token: widget.arguments['temporaryToken']);
                      await LocalStorage()
                          .localStorage('set', 'ai-token', value: token);
                      UserInfo().getUserInfo();
                      Get.offAll(() => const Home());
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
