import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/common/data.dart';
import 'package:kaino/components/actionSheets/cameraSheet.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/store.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Style extends StatefulWidget {
  const Style({super.key});

  @override
  State<Style> createState() => _StyleState();
}

class _StyleState extends State<Style> {
  String type = 'STYLE';
  late ScrollController _styleScrollController;
  late ScrollController _roomScrollController;

  onStyleScroll() {
    if (_styleScrollController.hasClients) {
      final selectedIndex = staticStyleList
          .indexWhere((map) => map['value'] == Controller.c.style.value);

      final screenWidth = MediaQuery.of(context).size.width;
      const itemWidth = 200 + 10;
      final targetScrollOffset =
          (selectedIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
      _styleScrollController.animateTo(
        targetScrollOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  onRoomScroll() {
    if (_roomScrollController.hasClients) {
      final selectedIndex = staticRoomList
          .indexWhere((map) => map['value'] == Controller.c.room.value);
      final screenWidth = MediaQuery.of(context).size.width;
      const itemWidth = 200 + 10;
      final targetScrollOffset =
          (selectedIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
      _roomScrollController.animateTo(
        targetScrollOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _styleScrollController = ScrollController();
    _roomScrollController = ScrollController();
    if (Controller.c.style.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onRoomScroll();
        onStyleScroll();
      });
    }
  }

  onSubmit() async {
    if (Controller.c.style.value.isEmpty) {
      Fluttertoast.showToast(
          msg: "SELECT_STYLE".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF4D97D3),
          textColor: const Color.fromARGB(255, 255, 255, 255),
          fontSize: 16.0);
      return;
    } else if (Controller.c.room.value.isEmpty) {
      Fluttertoast.showToast(
          msg: "SELECT_ROOM".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF4D97D3),
          textColor: const Color.fromARGB(255, 255, 255, 255),
          fontSize: 16.0);
      return;
    }

    if (Controller.c.user.isEmpty) {
      var token = await freeToken();
      if (token <= 0) {
        Fluttertoast.showToast(
            msg: "NO_CREDIT".tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF4D97D3),
            textColor: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 16.0);
        return;
      }
    }
    Navigator.pushNamed(context, '/rendering');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Style',
            style: TextStyle(color: Color(0xFF4D97D3), fontSize: 18),
          ),
          toolbarHeight: 40,
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          children: [
            SizedBox(
              height: 350,
              child: Center(
                child: Image.file(File(Controller.c.image['uri']!)),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(const CameraSheet());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 109, 155, 214)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      'CHANGE_PICTURE'.tr,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                type.tr,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      type = 'STYLE';
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: type == 'STYLE'
                          ? const Color.fromARGB(255, 211, 228, 246)
                          : Colors.transparent,
                    ),
                    child: Obx(() => Column(
                          children: [
                            Icon(
                              Icons.style,
                              color: Controller.c.style.isEmpty
                                  ? const Color(0xFFA9A9A9)
                                  : const Color(0xFF4D97D3),
                              size: 40,
                            ),
                            Text(
                              'STYLE'.tr,
                              style: TextStyle(
                                color: Controller.c.style.isEmpty
                                    ? const Color(0xFFA9A9A9)
                                    : const Color(0xFF4D97D3),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      type = 'ROOM';
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: type == 'ROOM'
                            ? const Color.fromARGB(255, 211, 228, 246)
                            : Colors.transparent,
                      ),
                      child: Obx(() => Column(
                            children: [
                              Icon(
                                Icons.home,
                                color: Controller.c.room.isEmpty
                                    ? const Color(0xFFA9A9A9)
                                    : const Color(0xFF4D97D3),
                                size: 40,
                              ),
                              Text(
                                'ROOM'.tr,
                                style: TextStyle(
                                  color: Controller.c.room.isEmpty
                                      ? const Color(0xFFA9A9A9)
                                      : const Color(0xFF4D97D3),
                                ),
                              )
                            ],
                          ))),
                )
              ],
            ),
            Container(
              height: 15,
            ),
            Visibility(
                visible: type == 'STYLE',
                child: SizedBox(
                  height: 158,
                  child: ListView(
                    key: const PageStorageKey('style'),
                    controller: _styleScrollController,
                    scrollDirection: Axis.horizontal,
                    children: staticStyleList
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Controller.c.style(e['value']);
                              onStyleScroll();
                            },
                            child: Obx(() => Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Controller.c.style == e['value']
                                          ? const Color.fromARGB(
                                              255, 113, 170, 216)
                                          : const Color.fromARGB(
                                              255, 176, 176, 176)),
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        e['uri'],
                                        height: 130,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          e['label'].toString().tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        )
                        .toList(),
                  ),
                )),
            Visibility(
                visible: type == 'ROOM',
                child: SizedBox(
                    height: 158,
                    child: ListView.builder(
                        key: const PageStorageKey('room'),
                        controller: _roomScrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: staticRoomList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Controller.c
                                    .room(staticRoomList[index]['value']);
                                onRoomScroll();
                              },
                              child: Obx(() => Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Controller.c.room ==
                                                staticRoomList[index]['value']
                                            ? const Color.fromARGB(
                                                255, 113, 170, 216)
                                            : const Color.fromARGB(
                                                255, 176, 176, 176)),
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          staticRoomList[index]['uri'],
                                          height: 130,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 3),
                                          child: Text(
                                            staticRoomList[index]['label']
                                                .toString()
                                                .tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        )
                                      ],
                                    ),
                                  )));
                        }))),
            Container(
              height: 15,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSubmit,
                  style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(255, 113, 170, 216)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: Text(
                    'GENERATE'.tr,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ));
  }
}
