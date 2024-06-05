import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Switchlan extends StatelessWidget {
  final Function onChange;
  const Switchlan({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      height: 150,
      child: Column(
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              var locale = const Locale('en', 'US');
              Get.updateLocale(locale);
              onChange('English');
              Get.back();
            },
          ),
          ListTile(
            title: const Text('中文'),
            onTap: () {
              var locale = const Locale('zh', 'CN');
              Get.updateLocale(locale);
              onChange('中文');
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
