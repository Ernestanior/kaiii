// ignore_for_file: invalid_use_of_protected_member, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/common/encrypt.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/store.dart';

class ChangePwd extends StatefulWidget {
  const ChangePwd({super.key});

  @override
  State<ChangePwd> createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  String oldPwd = '';
  String newPwd = '';
  String confirmPwd = '';
  String errMsg = '';
  @override
  Widget build(BuildContext context) {
    onSubmit() async {
      if ((oldPwd.isNotEmpty && newPwd.isNotEmpty && confirmPwd.isNotEmpty) ||
          (Controller.c.user.value['passwordStatus'] == 2 &&
              newPwd.isNotEmpty &&
              confirmPwd.isNotEmpty)) {
        RegExp exp = new RegExp(
            r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@!%*#?&])[A-Za-z\d$@!%*#?&]{8,}$");

        if (!exp.hasMatch(newPwd)) {
          setState(() {
            errMsg = 'PASSWORD_COMPLEX_INFO'.tr;
          });
          return;
        }
        if (Controller.c.user.value['passwordStatus'] != 2) {
          if (oldPwd == newPwd) {
            setState(() {
              errMsg = 'PASSWORD_CANNOT_BE_THE_SAME'.tr;
            });
            return;
          }
        }
        if (newPwd != confirmPwd) {
          setState(() {
            errMsg = 'THE_TWO_PASSWORDS_YOU_ENTERED_DO_NOT_MATCH'.tr;
          });
          return;
        }
        setState(() {
          errMsg = '';
        });
        String encryptOldPwd = encrypt(oldPwd);
        String encryptNewPwd = encrypt(newPwd);
        var res = await updatePwd(
            password: encryptOldPwd, newPassword: encryptNewPwd);
        if (res == '') {
          Get.back();
        } else if (res is String) {
          setState(() {
            errMsg = res;
          });
        }
      } else {
        setState(() {
          errMsg = 'PLEASE_COMPLETE_THE_INFORMATION'.tr;
        });
      }
    }

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      height: Controller.c.user.value['passwordStatus'] == 2 ? 330 : 410,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
          ),
          Visibility(
              visible: Controller.c.user.value['passwordStatus'] != 2,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        oldPwd = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'OLD_PASSWORD'.tr,
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                ],
              )),
          TextField(
            onChanged: (value) {
              setState(() {
                newPwd = value.trim();
              });
            },
            decoration: InputDecoration(
              hintText: 'NEW_PASSWORD'.tr,
            ),
          ),
          Container(
            height: 20,
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                confirmPwd = value.trim();
              });
            },
            decoration: InputDecoration(
              hintText: 'CONFIRM_PASSWORD'.tr,
            ),
          ),
          Container(
            height: 10,
          ),
          Visibility(
            visible: errMsg != '',
            child: Text(
              errMsg,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 24, 24), fontSize: 12),
            ),
          ),
          Container(
            height: 30,
          ),
          Text(
            'PASSWORD_REQUIREMENTS_DESC'.tr,
            style: const TextStyle(
                color: Color(
                  0xFF707070,
                ),
                fontSize: 12),
          ),
          Container(
            height: 10,
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
                onPressed: onSubmit,
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
