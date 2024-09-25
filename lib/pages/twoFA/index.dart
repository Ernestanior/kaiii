import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/components/actionSheets/cancel2Fa.dart';
import 'package:kaino/store/store.dart';

class TwoFa extends StatefulWidget {
  const TwoFa({super.key});

  @override
  State<TwoFa> createState() => _TwoFaState();
}

class _TwoFaState extends State<TwoFa> {
  changeStates(bool value) {
    if (value) {
      Navigator.pushNamed(context, '/authDetail');
    } else {
      Get.bottomSheet(const Cancel2fa());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('2FA'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('TWO_FACTOR_AUTHENTICATION'.tr),
                  Switch(
                      activeColor: Colors.blue,
                      value: Controller.c.user['twoFactorAuthStatus'],
                      onChanged: changeStates)
                ],
              ),
              Text(
                'USING_2FA'.tr,
                style: const TextStyle(
                    fontSize: 11, color: Color.fromARGB(115, 32, 32, 32)),
              )
            ],
          ),
        ));
  }
}
