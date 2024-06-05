import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/components/actionSheets/switchLan.dart';
import 'package:kaino/store/store.dart';
import 'package:kaino/store/token.dart';
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
  @override
  void initState() {
    UserInfo().getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> styleList = staticStyleList
        .map(
          (e) => Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 176, 176, 176)),
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Image.asset(
                  e['uri'],
                  height: 130,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  child: Text(
                    e['label'].toString().tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                )
              ],
            ),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 60,
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
              )
            ],
          )
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    'TAGLINE1'.tr,
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(198, 84, 124, 187)),
                  ),
                  Text(
                    'TAGLINE2'.tr,
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(198, 84, 124, 187)),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'TAGLINE_DESC1'.tr,
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(197, 110, 110, 110)),
                ),
                Text(
                  'TAGLINE_DESC2'.tr,
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
                  print(await LocalStorage().localStorage('get', 'ai-token'));
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
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Image.asset(
                'assets/home/1.jpg',
              ),
            ),
            SizedBox(
              height: 158,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: styleList,
              ),
            )
          ],
        ),
      ),
    );
  }
}
