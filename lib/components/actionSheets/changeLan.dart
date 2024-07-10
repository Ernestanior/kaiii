import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/store.dart';
import 'package:kaino/store/user.dart';

class ChangeLan extends StatefulWidget {
  const ChangeLan({super.key});

  @override
  State<ChangeLan> createState() => _ChangeLanState();
}

class _ChangeLanState extends State<ChangeLan> {
  String selectedLanguage =
      Controller.c.language.value == "en_US" ? 'English' : '中文';

  @override
  Widget build(BuildContext context) {
    onSubmit() async {
      await updateUser(
          {'locale': selectedLanguage == 'English' ? 'en_US' : 'zh_CN'});
      UserInfo().getUserInfo();
      Get.back();
    }

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      height: 280,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LANGUAGE'.tr,
            style: const TextStyle(
                color: Color.fromARGB(255, 89, 141, 204),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguage = 'English';
              });
            },
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('English'),
                  Visibility(
                      visible: selectedLanguage == 'English',
                      child: const Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 44, 107, 201),
                      )),
                ],
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguage = '中文';
              });
            },
            child: Container(
              height: 50,
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('中文'),
                  Visibility(
                      visible: selectedLanguage == '中文',
                      child: const Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 44, 107, 201),
                      ))
                ],
              ),
            ),
          ),
          const Divider(),
          Container(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: onSubmit,
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(const Color(0xFF76AEDC)),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                child: Text('CONFIRM'.tr),
              ))
            ],
          )
        ],
      ),
    );
  }
}
