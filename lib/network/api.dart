import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      'user-agent': Controller.c.userAgent.value,
      // 'token': token.toString(),
      'Finger-Print': 'aahga'
      // 'Finger-Print': Controller.c.deviceId.value
    };
    if (token != null && token != "2FA验证失败, 请检查后再次尝试") {
      initHeaders['token'] = token;
    }
    print(init_url + path);
    print(initHeaders);

    var res = await request(init_url + path, method,
        headers: initHeaders, body: body, query: query);
    // print('body');
    // print(res.request);
    // print(res.body);
    if (res.body != null) {
      if (pass) {
        return res;
      } else {
        if (res.body is String) {
          print('404');
          return res.body;
        } else {
          if (res.body['code'] == 200) {
            return res.body['data'];
          } else if (res.body['code'] == 10001) {
            Controller.c.user({});
            LocalStorage().localStorage('remove', 'ai-token');
            Get.offAll(() => const Login());
            return 'token过期';
          }
          //  else if (res.body['code'] == 10600) {
          //   return '二次验证未通过';
          // }
          else {
            Fluttertoast.showToast(
                msg: res.body['msg'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: const Color(0xFF4D97D3),
                textColor: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 16.0);
            return res.body['msg'];
          }
        }
      }
    }
  }
}

Future getBaseUrl() => ApiConnect().httpRequest('/info/app', 'get');
Future login(Map data) =>
    ApiConnect().httpRequest('/user/login', 'post', body: data);
Future register(Map data) =>
    ApiConnect().httpRequest('/user/register', 'post', body: data);
Future googleLogin(String token) => ApiConnect()
    .httpRequest('/user/google-login', 'get', query: {'token': token});
Future appleLogin(dynamic data) =>
    ApiConnect().httpRequest('/user/apple-login', 'post', body: data);
Future getUserDetail() => ApiConnect().httpRequest('/user/detail', 'get');
Future updateUser(Map data) =>
    ApiConnect().httpRequest('/user/update', 'put', body: data);
Future updatePwd({required String password, required String newPassword}) =>
    ApiConnect().httpRequest('/user/update-password', 'put',
        body: {'password': password, 'newPassword': newPassword});
Future deleteUser(String remarks) =>
    ApiConnect().httpRequest('/user/delete', 'put', body: {'remarks': remarks});
Future imgHistory(Map data) =>
    ApiConnect().httpRequest('/img/history', 'post', body: data);
Future freeToken() => ApiConnect().httpRequest('/user/img/free-token', 'get');
Future base64Upload(FormData data) =>
    ApiConnect().httpRequest('/img/app/upload', 'post', body: data);
Future imgRender(dynamic data) =>
    ApiConnect().httpRequest('/img/render', 'post', body: data);
Future imgProgress(String taskId) =>
    ApiConnect().httpRequest('/img/progress', 'get', query: {'taskId': taskId});
Future imgResult(String taskId) =>
    ApiConnect().httpRequest('/img/result', 'get', query: {'taskId': taskId});
Future imgDelete(int id) => ApiConnect()
    .httpRequest('/img/delete', 'delete', query: {'id': id.toString()});
Future imgDeleteVisitor(int id) => ApiConnect()
    .httpRequest('/img/delete/render-visitor', 'delete', query: {'id': id});
Future renderCancel(String id) =>
    ApiConnect().httpRequest('/img/render', 'put', query: {'taskId': id});
Future googleAuthCodeDisable() => ApiConnect().httpRequest(
      '/user/google-auth-code-disable',
      'get',
    );
Future googleAuthCode() => ApiConnect().httpRequest(
      '/user/google-auth-code',
      'get',
    );

Future verifyAuthCode(String code, {String? token}) =>
    ApiConnect().httpRequest('/user/verify-auth-code', 'get',
        query: {'code': code}, headers: token == null ? {} : {'token': token});
