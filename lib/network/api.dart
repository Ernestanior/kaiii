import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/pages/login/index.dart';
import 'package:kaino/store/store.dart';
import 'package:kaino/store/token.dart';

String APP_VERSION = 'v1.2.15';
// String init_url = 'https://www.kainoai.com/api/v1';
String init_url = 'https://ai.stream-svc.com/api/v1';

class ApiConnect extends GetConnect {
  // Future httpGet(String path,
  //     {Map<String, dynamic>? params,
  //     Map<String, String>? headers,
  //     bool pass = false}) async {
  //   final token = await LocalStorage().localStorage('get', 'ai-token');
  //   final initHeaders = {
  //     ...?headers,
  //     'app-user-locale': 'zh_CN',
  //     'version': APP_VERSION,
  //     'userAgent': userAgent,
  //     'token': token.toString()
  //   };
  //   var res = await get(init_url + path, query: params, headers: initHeaders);
  //   if (pass) {
  //     return res;
  //   } else {
  //     if (res.body['code'] == 200) {
  //       return res.body['data'];
  //     } else if (res.body['code'] == 10001) {
  //       Controller.c.user({});
  //       LocalStorage().localStorage('remove', 'ai-token');
  //       Get.offAll(() => const Login());
  //       return 'token过期';
  //     } else if (res.body['code'] == 10600) {
  //       return '二次验证未通过';
  //     } else {
  //       return res.body['msg'];
  //     }
  //   }
  // }

  // Future httpPost(String path, Map data,
  //     {Map<String, String>? headers, bool pass = false}) async {
  //   final token = await LocalStorage().localStorage('get', 'ai-token');
  //   final initHeaders = {
  //     ...?headers,
  //     'app-user-locale': 'zh_CN',
  //     'version': APP_VERSION,
  //     'userAgent': userAgent,
  //     'token': token.toString(),
  //   };
  //   var res = await post(init_url + path, data, headers: initHeaders);
  //   if (pass) {
  //     return res;
  //   } else {
  //     if (res.body is String) {
  //       print('404');
  //     } else {
  //       if (res.body['code'] == 200) {
  //         return res.body['data'];
  //       } else if (res.body['code'] == 10001) {
  //         Controller.c.user({});
  //         LocalStorage().localStorage('remove', 'ai-token');
  //         Get.offAll(() => const Login());
  //         return 'token过期';
  //       } else if (res.body['code'] == 10600) {
  //         return '二次验证未通过';
  //       } else {
  //         return res.body['msg'];
  //       }
  //     }
  //   }
  // }

  Future httpRequest(
    String path,
    String method, {
    Map<String, String>? headers,
    bool pass = false,
    Map<String, dynamic>? query,
    dynamic body,
  }) async {
    final token = await LocalStorage().localStorage('get', 'ai-token');
    final initHeaders = {
      ...?headers,
      'app-user-locale': 'zh_CN',
      'version': APP_VERSION,
      'userAgent': userAgent,
      'token': token.toString(),
    };
    var res = await request(init_url + path, method,
        headers: initHeaders, body: body, query: query);
    if (pass) {
      return res;
    } else {
      if (res.body is String) {
        print('404');
      } else {
        if (res.body['code'] == 200) {
          return res.body['data'];
        } else if (res.body['code'] == 10001) {
          Controller.c.user({});
          LocalStorage().localStorage('remove', 'ai-token');
          Get.offAll(() => const Login());
          return 'token过期';
        } else if (res.body['code'] == 10600) {
          return '二次验证未通过';
        } else {
          return res.body['msg'];
        }
      }
    }
  }

  Future getBaseUrl() => httpRequest('/info/app', 'get');
  Future login(Map data) => httpRequest('/user/login', 'post', body: data);
  Future googleLogin(String token) =>
      httpRequest('/user/google-login', 'get', query: {'token': token});
  Future getUserDetail() => httpRequest('/user/detail', 'get');
  Future updateUser(Map data) => httpRequest('/user/update', 'put', body: data);
}
