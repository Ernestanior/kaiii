import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/pages/home/index.dart';
import 'package:kaino/store/user.dart';

class Cancel2fa extends StatefulWidget {
  const Cancel2fa({super.key});

  @override
  State<Cancel2fa> createState() => _Cancel2faState();
}

class _Cancel2faState extends State<Cancel2fa> {
  @override
  Widget build(BuildContext context) {
    onSubmit() async {
      await googleAuthCodeDisable();
      UserInfo().getUserInfo();
      Get.back();
    }

    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        height: 190,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Container(
                  width: 5,
                ),
                Text(
                  'DISABLE'.tr,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'DISABLE_2FA'.tr,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text('CANCEL'.tr),
                  ),
                ),
                Container(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                  onPressed: onSubmit,
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: Text('CONFIRM'.tr),
                ))
              ],
            )
          ],
        ));
  }
}
