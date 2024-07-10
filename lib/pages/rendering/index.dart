import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/components/actionSheets/cancelRender.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/store.dart';

class Rendering extends StatefulWidget {
  const Rendering({super.key});

  @override
  State<Rendering> createState() => _RenderingState();
}

class _RenderingState extends State<Rendering> with TickerProviderStateMixin {
  double progress = 0;
  late AnimationController controller;
  String taskId = '';
  String info = '';

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    // controller.animateTo(0.3);
    getTaskId();
    super.initState();
  }

  getTaskId() async {
    // if (Controller.c.image['base64'] == '') {
    // } else {}
    // var formData = FormData({'file': Controller.c.image['base64']});
    // dynamic imgUrl = await base64Upload(formData);

    dynamic id = await imgRender({
      'imgUrl': Controller.c.imgUrl.value,
      'room': Controller.c.room.value,
      'style': Controller.c.style.value,
      'batchSize': 1
    });
    if (mounted) {
      setState(() {
        taskId = id;
        fetchData();
      });
    }
  }

  Future<void> fetchData() async {
    final res = await imgProgress(taskId);

    if (res == "Task executed successfully.") {
      final imgDetail = await imgResult(taskId);
      if (mounted) {
        setState(() {
          info = 'TASK_EXECUTED_SUCCESSFULLY'.tr;
        });
        Navigator.pushReplacementNamed(context, '/renderPreview',
            arguments: imgDetail);
      }
    } else {
      try {
        double p = double.parse(res);
        if (mounted) {
          setState(() {
            progress = p;
            info = 'RENDERING'.tr;
          });
          controller.animateTo(p);
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            info = res;
          });
        }
      }
      Timer(const Duration(seconds: 2), fetchData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
      child: Column(
        children: [
          Container(
            height: 50,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      backgroundColor: const Color.fromARGB(255, 135, 181, 219),
                      valueColor: const AlwaysStoppedAnimation(
                          Color.fromARGB(255, 60, 86, 137)),
                      value: controller.value,
                      strokeWidth: 20,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 113, 170, 216),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500,
                        fontSize: 34),
                  )
                ],
              ),
              Container(
                height: 20,
              ),
              Text(
                info,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none),
              )
            ],
          )),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(CancelRender(id: taskId));
                },
                style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 113, 170, 216)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                child: Text(
                  'CANCEL'.tr,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
