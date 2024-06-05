import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePwd extends StatefulWidget {
  const ChangePwd({super.key});

  @override
  State<ChangePwd> createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      height: 310,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'NEW_PASSWORD'.tr,
            ),
          ),
          Container(
            height: 30,
          ),
          TextField(
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'CONFIRM_PASSWORD'.tr,
            ),
          ),
          Container(
            height: 30,
          ),
          Text(
            'PASSWORD_REQUIREMENTS_DESC'.tr,
            style: const TextStyle(color: Color(0xFF707070)),
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
                onPressed: () {},
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
