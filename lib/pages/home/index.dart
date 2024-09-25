import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/components/actionSheets/cameraSheet.dart';
import 'package:kaino/components/actionSheets/switchLan.dart';
import 'package:kaino/components/actionSheets/upgrade.dart';
import 'package:kaino/components/draggableDivider/localeImg.dart';
import 'package:kaino/store/store.dart';
import 'package:kaino/store/user.dart';
import '../../common/data.dart';
import '../../common/icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String language = 'English';
  String style = staticStyleList[0]['value'];
  String homeImg = staticStyleList[0]['uri'];

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    UserInfo().getUserInfo();

    // Restore scroll position if needed
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   onScroll();
    // });
  }

  onScroll() {
    if (_scrollController.hasClients) {
      final selectedIndex =
          staticStyleList.indexWhere((map) => map['value'] == style);

      final screenWidth = MediaQuery.of(context).size.width;
      const itemWidth = 200 + 10;
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 65,
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
          Row(
            children: [
              Visibility(
                visible: Controller.c.user.isEmpty,
                child: GestureDetector(
                  onTap: () {
                    Get.bottomSheet(Switchlan(
                      onChange: (e) {
                        setState(() {
                          language = e;
                        });
                      },
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      language,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Controller.c.user.isEmpty) {
                    Navigator.pushNamed(context, '/login');
                  } else {
                    Navigator.pushNamed(context, '/profile');
                  }
                },
                child: const Icon(
                  KainoIcon.user,
                  color: Colors.blue,
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/canvas');
              //   },
              //   child: const Icon(
              //     KainoIcon.token,
              //     color: Colors.blue,
              //   ),
              // )
            ],
          )
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'MAKE_THE'.tr,
                    style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(198, 84, 124, 187)),
                  ),
                  Text(
                    'DESIGN_EASIER'.tr,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(198, 84, 124, 187)),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'UPLOAD_SPACE_PHOTO__CONFIGURE_RENDERING_PARAMETERS_1'.tr,
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(197, 110, 110, 110)),
                ),
                Text(
                  'UPLOAD_SPACE_PHOTO__CONFIGURE_RENDERING_PARAMETERS_2'.tr,
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(197, 110, 110, 110)),
                ),
              ],
            ),
            Container(
              width: 300,
              height: 50,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (Controller.c.user.isEmpty) {
                    Get.bottomSheet(const Upgrade());
                  } else {
                    Get.bottomSheet(const CameraSheet());
                  }
                },
                style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 113, 170, 216))),
                child: Text(
                  'GET_YOUR_DESIGN'.tr,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
              child: LocaleDraggableDivider(
                  leftImage: 'assets/home/1.jpg',
                  rightImage: homeImg,
                  imgWidth: MediaQuery.of(context).size.width.toInt(),
                  imgHeight: 250),
            ),
            SizedBox(
              height: 158,
              child: ListView(
                key: const PageStorageKey('homeImg'),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: staticStyleList
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            style = e['value'];
                            homeImg = e['uri'];
                          });
                          onScroll();
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: style == e['value']
                                  ? const Color.fromARGB(255, 113, 170, 216)
                                  : const Color.fromARGB(255, 176, 176, 176)),
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
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
