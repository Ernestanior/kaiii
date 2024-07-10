import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/pages/home/index.dart';
import 'package:kaino/store/store.dart';

class DeleteImage extends StatefulWidget {
  int id;
  DeleteImage({super.key, required this.id});

  @override
  State<DeleteImage> createState() => _DeleteImageState();
}

class _DeleteImageState extends State<DeleteImage> {
  @override
  Widget build(BuildContext context) {
    onSubmit() async {
      if (Controller.c.user.isEmpty) {
        await imgDeleteVisitor(widget.id);
      } else {
        await imgDelete(widget.id);
      }
      // Get.back();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
        return const Home();
      }), (route) => false);
      Navigator.pushNamed(context, '/profile');
    }

    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        height: 170,
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
                  'DELETE_IMAGE'.tr,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'SURE_TO_DELETE_IMAGE'.tr,
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
