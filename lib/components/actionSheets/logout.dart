import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/pages/home/index.dart';
import 'package:kaino/store/store.dart';
import 'package:kaino/store/token.dart';

class LogoutSheet extends StatelessWidget {
  const LogoutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    onLogout() {
      Controller.c.user({});
      LocalStorage().localStorage('remove', 'ai-token');
      Get.back();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
        return const Home();
      }), (route) => false);
    }

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      height: 180,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LOGOUT'.tr,
            style: const TextStyle(
                color: Color.fromARGB(255, 89, 141, 204),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'SURE_TO_LOGOUT'.tr,
            style: const TextStyle(color: Color(0xFF707070)),
          ),
          Container(
            height: 20,
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
                onPressed: onLogout,
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
