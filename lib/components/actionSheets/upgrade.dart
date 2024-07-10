import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/components/actionSheets/cameraSheet.dart';

class Upgrade extends StatefulWidget {
  const Upgrade({super.key});

  @override
  State<Upgrade> createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              Get.bottomSheet(const CameraSheet());
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFEFEFEF),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'FREE_TRIAL'.tr,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 56, 82, 148),
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    'ENJOY_COMPLIMENTARY_CREDITS_DAILY'.tr,
                    style: const TextStyle(
                        fontSize: 10, color: Color.fromARGB(255, 56, 82, 148)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 113, 170, 216),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              children: [
                Text(
                  'REGISTER_ACCOUNT'.tr,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'CLAIM_100_PROFESSIONAL_RENDERING_CREDITS_FOR_FREE'.tr,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
