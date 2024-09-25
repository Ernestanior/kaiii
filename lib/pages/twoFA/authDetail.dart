import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kaino/components/loading/index.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/store.dart';
import 'package:flutter/services.dart';

class Authdetail extends StatelessWidget {
  const Authdetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          'AUTHENTICATION'.tr,
          style: const TextStyle(color: Color(0xFF4D97D3), fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.qr_code_scanner,
              size: 100,
              color: Color.fromARGB(255, 82, 82, 82),
            ),
            Container(
              height: 20,
            ),
            Text('GET_LOGIN_CODE'.tr),
            Container(
              height: 20,
            ),
            FutureBuilder(
                future: googleAuthCode(),
                builder: (BuildContext context, AsyncSnapshot snpashot) {
                  if (snpashot.connectionState == ConnectionState.waiting) {
                    return const Loading();
                  } else {
                    if (snpashot.hasError) {
                      return Text("Error:${snpashot.error}");
                    } else {
                      Map data = snpashot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.memory(
                            base64Decode(data['code']),
                            width: 200,
                            height: 200,
                          ),
                          Container(
                            height: 20,
                          ),
                          Text(
                            'CANNOT_SCAN_THE_QR_CODE_ADD_MANUALLY_PART_2'.tr,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${'ACCOUNT'.tr}: ",
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${Controller.c.user['userName'] ?? "-"}",
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${'KEY'.tr}: ",
                                style: const TextStyle(fontSize: 12),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await Clipboard.setData(
                                      ClipboardData(text: data['secret']));
                                  Fluttertoast.showToast(
                                      msg: "COPY".tr,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: const Color(0xFF4D97D3),
                                      textColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 16.0);
                                },
                                child: Text(
                                  "${data['secret'] ?? "-"}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'CANNOT_SCAN_THE_QR_CODE_ADD_MANUALLY_PART_5'.tr,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Container(
                            height: 10,
                          ),
                          Text(
                            'SAVE_PASSWORD_2FA'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Container(
                            height: 120,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/enterCode');
                              },
                              child: Text('NEXT'.tr))
                        ],
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
