import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/components/actionSheets/changeLan.dart';
import 'package:kaino/components/actionSheets/changePwd.dart';
import 'package:kaino/components/actionSheets/logout.dart';
import 'package:kaino/store/store.dart';

class Preference extends StatefulWidget {
  const Preference({super.key});

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'PREFERENCE'.tr,
            style: const TextStyle(color: Color(0xFF4D97D3)),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: -2,
                              color: Color(0xFFA4A4A4)),
                        ]),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 140, child: Text('EMAIL'.tr)),
                              Expanded(
                                  child: Text(
                                Controller.c.user['userName'],
                                style:
                                    const TextStyle(color: Color(0xFF6594B5)),
                              )),
                              Container()
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(const ChangeLan());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 25),
                            decoration:
                                const BoxDecoration(color: Color(0xFFF0F0F0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 140, child: Text('LANGUAGE'.tr)),
                                Expanded(
                                    child: Text(
                                  Controller.c.user['locale'],
                                  style:
                                      const TextStyle(color: Color(0xFF6594B5)),
                                )),
                                const Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(const ChangePwd());
                          },
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 140, child: Text('PASSWORD'.tr)),
                                const Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 25),
                            decoration:
                                const BoxDecoration(color: Color(0xFFF0F0F0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 140,
                                    child: Text('DELETE_ACCOUNT'.tr)),
                                const Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(const LogoutSheet());
                    },
                    child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: -2,
                                  color: Color.fromARGB(255, 184, 184, 184)),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LOGOUT'.tr,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF4D97D3)),
                            ),
                          ],
                        )),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CONTACT_FOR_QUESTIONS'.tr,
                        style: const TextStyle(color: Color(0xFF6A6A6A)),
                      ),
                      const Text(
                        'enquiry@kainoai.com',
                        style: TextStyle(color: Color(0xFF2E88D1)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'VERSION'.tr,
                        style: const TextStyle(color: Color(0xFF6A6A6A)),
                      ),
                      const Text(
                        ': v1.2.15',
                        style: TextStyle(color: Color(0xFF6A6A6A)),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
