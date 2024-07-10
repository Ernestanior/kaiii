import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/common/encrypt.dart';
import 'package:kaino/common/service.dart';
import 'package:kaino/common/utils.dart';
import 'package:kaino/components/squareTile/index.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/pages/home/index.dart';
import 'package:kaino/store/store.dart';
import 'package:kaino/store/token.dart';
import 'package:kaino/store/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool remember = true;
  String username = '';
  String password = '';
  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    verify2fa(res) async {
      if (res?['twoFactorAuth'] == 1) {
      } else {}
    }

    onGoogleLogin() async {
      final googleToken = await GoogleAuthService().signInWithGoogle();
      if (googleToken != null) {
        final res = await googleLogin(googleToken);
        await LocalStorage()
            .localStorage('set', 'ai-token', value: res['token']);
        UserInfo().getUserInfo();
        Get.offAll(() => const Home());
      }
    }

    Future<void> onAppleLogin() async {
      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          nonce: '123',
          scopes: [
            AppleIDAuthorizationScopes.email,
          ],
        );
        final res = await appleLogin({
          'identityToken': credential.identityToken,
          'nonce': '123',
          'platform': 'com.gp.kaino',
          'authorizationCode': credential.authorizationCode
        });
        await LocalStorage()
            .localStorage('set', 'ai-token', value: res['token']);
        UserInfo().getUserInfo();
        Get.offAll(() => const Home());
      } catch (e) {
        print(e);
      }
    }

    onSubmit() async {
      if (username == '' || password == '') {
        setState(() {
          errMsg = "USERNAME_OR_PASSWORD_CANNOT_BE_EMPTY".tr;
        });
        return null;
      }
      if (!Utils().validateEmail(username)) {
        setState(() {
          errMsg = "USERNAME_OR_PASSWORD_CANNOT_BE_EMPTY".tr;
        });
        return null;
      }
      final data = {
        'username': username,
        'password': encrypt(password),
        'remember': remember ? 1 : 0,
        'response': 'app'
      };
      dynamic res = await login(data);
      Controller.c.token(res['token']);
      await LocalStorage().localStorage('set', 'ai-token', value: res['token']);
      Get.offAll(() => const Home());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: 240,
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 120,
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        username = value.trim();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  ),
                ],
              )),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: remember,
                        onChanged: (e) {
                          setState(() {
                            remember = e as bool;
                          });
                        }),
                    Text('REMEMBER_ME'.tr)
                  ],
                ),
                GestureDetector(
                  child: Text(
                    'FORGOT_PASSWORD'.tr,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 350,
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () => onSubmit(),
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 113, 170, 216))),
              child: Text('LOGIN'.tr),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('NO_ACCOUNT_YET'.tr),
                const Text('   '),
                Text(
                  'SIGN_UP_HERE'.tr,
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SquareTile(imagePath: 'assets/google.png', onTap: onGoogleLogin),
            SquareTile(imagePath: 'assets/apple.png', onTap: onAppleLogin),
          ])
        ],
      ),
    );
  }
}
