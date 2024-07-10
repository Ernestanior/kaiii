import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/store.dart';
import 'package:kaino/store/token.dart';

class UserInfo {
  getUserInfo() async {
    final token = await LocalStorage().localStorage('get', 'ai-token');

    if (token != null) {
      final res = await getUserDetail();
      if (res is String) {
        return;
      }
      var locale;
      if (res['locale'] == 'en_US') {
        locale = const Locale('en', 'US');
        Get.updateLocale(locale);
      } else {
        locale = const Locale('zh', 'CN');
        Get.updateLocale(locale);
      }
      Controller.c.user(res);
      Controller.c.language(res['locale']);
    } else {
      Controller.c.user({});
    }
  }
}
