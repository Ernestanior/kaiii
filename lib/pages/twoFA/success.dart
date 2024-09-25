import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/components/loading/index.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/store.dart';

class AuthSuccess extends StatelessWidget {
  const AuthSuccess({super.key});

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
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.task_alt,
              size: 100,
              color: Color.fromARGB(255, 136, 188, 216),
            ),
            Column(
              children: [
                Text(
                  'TWOFA_ON'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 20,
                ),
                Text('ADDITIONAL_CODE'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 104, 104, 104))),
              ],
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('DONE'))
          ],
        ),
      ),
    );
  }
}
