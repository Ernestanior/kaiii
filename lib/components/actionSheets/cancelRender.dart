import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/pages/home/index.dart';

class CancelRender extends StatefulWidget {
  String id;
  CancelRender({super.key, required this.id});

  @override
  State<CancelRender> createState() => _CancelRenderState();
}

class _CancelRenderState extends State<CancelRender> {
  @override
  Widget build(BuildContext context) {
    onSubmit() async {
      await renderCancel(widget.id);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
        return const Home();
      }), (route) => false);
    }

    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        height: 230,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Container(
                  width: 5,
                ),
                Text(
                  'CANCEL'.tr,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'CANCEL_RENDER'.tr,
              ),
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
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: Text('CONFIRM'.tr),
                ))
              ],
            )
          ],
        ));
  }
}
