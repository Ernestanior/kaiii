import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/pages/home/index.dart';
import 'package:kaino/store/store.dart';
import 'package:kaino/store/token.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount>
    with WidgetsBindingObserver {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool reason1 = false;
  bool reason2 = false;
  bool reason3 = false;
  String remark = '';
  @override
  Widget build(BuildContext context) {
    onSubmit() async {
      List newText = [];
      if (reason1) newText.add('不再需要使用该服务');
      if (reason2) newText.add('用户体验不佳');
      if (reason3) newText.add('不再需要使用该服务');
      if (remark != '') newText.add("备注：$remark");
      dynamic res = await deleteUser(remark);
      if (res == '') {
        Controller.c.user({});
        LocalStorage().localStorage('remove', 'ai-token');
        Get.back();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return const Home();
        }), (route) => false);
      }
    }

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      height: 370,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(
              Icons.warning,
              color: Colors.red,
            ),
            Container(
              width: 5,
            ),
            Text(
              'CLOSE_ACCOUNT'.tr,
              style: const TextStyle(
                  color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            )
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10,
              ),
              Text(
                'PLEASE_CHOOSE_REASON'.tr,
                style: const TextStyle(color: Color(0xFF707070)),
              ),
              SizedBox(
                height: 30,
                child: CheckboxListTile(
                    value: reason1,
                    activeColor: Colors.red,
                    title: Text(
                      'DONT_NEED_THIS_SERVICE'.tr,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5F5F5F)),
                    ),
                    onChanged: (e) {
                      setState(() {
                        reason1 = e!;
                      });
                    }),
              ),
              SizedBox(
                height: 30,
                child: CheckboxListTile(
                    value: reason2,
                    activeColor: Colors.red,
                    title: Text(
                      'BAD_USE_EXPERIENCE'.tr,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5F5F5F)),
                    ),
                    onChanged: (e) {
                      setState(() {
                        reason2 = e!;
                      });
                    }),
              ),
              SizedBox(
                height: 30,
                child: CheckboxListTile(
                    value: reason3,
                    // checkColor: WidgetStateProperty.all(Colors.red),
                    activeColor: Colors.red,
                    title: Text(
                      'FOUND_A_BETTER_ALTERNATIVE'.tr,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5F5F5F)),
                    ),
                    onChanged: (e) {
                      setState(() {
                        reason3 = e!;
                      });
                    }),
              ),
              Container(
                height: 20,
              ),
              Text('REMARK'.tr),
              Card(
                  color: Color.fromARGB(255, 250, 250, 250),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (e) {
                        setState(() {
                          remark = e;
                        });
                      },
                      style: TextStyle(fontSize: 13),
                      onTapOutside: (e) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: _controller,
                      focusNode: _focusNode,
                      maxLines: 3, //or null
                      decoration: const InputDecoration.collapsed(
                          hintText: "Enter your text here",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ))
            ],
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
