import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kaino/components/actionSheets/deleteImage.dart';
import 'package:kaino/components/draggableDivider/index.dart';
import 'package:kaino/components/imgView/index.dart';
import 'package:kaino/store/store.dart';

import 'package:share_plus/share_plus.dart';

class RenderDetail extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const RenderDetail({super.key, required this.arguments});

  @override
  State<RenderDetail> createState() => _RenderDetailState();
}

class _RenderDetailState extends State<RenderDetail> {
  Map<String, dynamic> item = {};
  int selectedIndex = 0;
  int imgWidth = 0;
  int imgHeight = 0;
  bool renderInfo = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    setState(() {
      item = widget.arguments;
      imgWidth = widget.arguments['renderDetail']['width'];
      imgHeight = widget.arguments['renderDetail']['height'];
    });
  }

  onScroll() {
    print(imgWidth);
    print(imgHeight);

    if (_scrollController.hasClients) {
      final screenWidth = MediaQuery.of(context).size.width;
      final itemWidth = imgWidth / imgHeight * 133;
      final targetScrollOffset =
          (selectedIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
      _scrollController.animateTo(
        targetScrollOffset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: Text(
            'RENDER_DETAIL'.tr,
            style: const TextStyle(color: Color(0xFF4D97D3), fontSize: 18),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                  height: 150,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    children: item['renderImgUris']
                        .asMap()
                        .entries
                        .map((e) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = e.key;
                              });
                              onScroll();
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: selectedIndex == e.key
                                            ? const Color.fromARGB(
                                                255, 151, 255, 212)
                                            : Colors.transparent,
                                        width: 3)),
                                child: Image.network(
                                  e.value,
                                )),
                          );
                        })
                        .toList()
                        .cast<Widget>(),
                  ),
                ),
                DraggableDivider(
                    leftImage: item['imgUri'] ?? item['oritinImgUri'],
                    rightImage: item['renderImgUris'][selectedIndex],
                    imgWidth: imgWidth,
                    imgHeight: imgHeight)
              ],
            )),
            Visibility(
                visible: renderInfo,
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 50),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 77, 77, 77)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${'CREATED_TIME'.tr}: ",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(DateTime.parse(item['createDateTime'])),
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${'STYLE'.tr}: ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            item['renderParameter']['style'],
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${'ROOM'.tr}: ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            item['renderParameter']['room'],
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        renderInfo = !renderInfo;
                      });
                    },
                    child: const Icon(
                      Icons.info,
                      size: 40,
                      color: Color.fromARGB(255, 97, 97, 97),
                    ),
                  ),
                  IconX(
                    onClick: () async {
                      await GallerySaver.saveImage(
                          item['renderImgUris'][selectedIndex]);
                      // print('Image downloaded to: ${file.path}');
                      Fluttertoast.showToast(
                          msg: "SAVE_SUCCESS".tr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: const Color(0xFF4D97D3),
                          textColor: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16.0);
                    },
                    icon: const Icon(
                      Icons.download,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                  IconX(
                    onClick: () async {
                      Controller.c.imgUrl(item['imgUri']);
                      Controller.c.style(item['renderParameter']['style']);
                      Controller.c.room(item['renderParameter']['room']);
                      Navigator.pushNamed(context, '/rendering');
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                  IconX(
                    onClick: () {
                      Share.shareXFiles(
                          [XFile(item['renderImgUris'][selectedIndex])],
                          text: item['renderImgUris'][selectedIndex]);
                    },
                    icon: const Icon(
                      Icons.share,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                  IconX(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePage(
                              imageUrl: item['renderImgUris'][selectedIndex]),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.zoom_out_map,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                  Visibility(
                      visible: item['id'] != null,
                      child: IconX(
                        onClick: () {
                          Get.bottomSheet(DeleteImage(
                            id: item['id'],
                          ));
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 21,
                          color: Colors.white,
                        ),
                      )),
                  Visibility(
                      visible: item['id'] != null,
                      child: Container(
                        width: 10,
                      )),
                ],
              ),
            )
          ],
        ));
  }
}

class IconX extends StatelessWidget {
  final onClick;
  Widget icon;
  IconX({super.key, this.onClick, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 97, 97, 97),
            borderRadius: BorderRadius.circular(18)),
        child: icon,
      ),
    );
  }
}
