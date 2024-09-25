import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({super.key});

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 91, 91, 91)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  border: Border.all(color: Colors.white, width: 8)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 90,
              ),
            ),
            Container(
              height: 50,
            ),
            Text(
              textAlign: TextAlign.center,
              'REGISTRATION_SUCCESSFUL'.tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('WE_HAVE_SENT_EMAIL_TO_YOU'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      )),
                  Container(
                    height: 20,
                  ),
                  Text(
                      'PLEASE_CLICK_ON_THE_LINK_IN_THAT_EMAIL_TO_ACTIVATE_YOUR_ACCOUNT'
                          .tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      )),
                  Container(
                    height: 20,
                  ),
                  Text('PLEASE_CLICK_THE_BUTTON_BELOW_TO_RESEND'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      )),
                ],
              ),
            ),
            Container(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(const Size(200, 20))),
              child: Text(
                'RESEND'.tr,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(const Size(200, 20))),
              child: Text(
                'LOGIN'.tr,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
