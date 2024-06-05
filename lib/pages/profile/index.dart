import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/common/icons.dart';
import 'package:kaino/store/store.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool remember = true;
  Map<String, dynamic> currUser = {};
  @override
  void initState() {
    super.initState();
    setState(() {
      currUser = Controller.c.user;
    });
  }

  @override
  Widget build(BuildContext context) {
    onSubmit() {}
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PROFILE'.tr,
            style: const TextStyle(color: Color(0xFF4D97D3), fontSize: 18),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(currUser['userName']),
                  ],
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: -2,
                              color: Color(0xFF4D97D3)),
                        ]),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            KainoIcon.token,
                            color: Color(0xFF4D97D3),
                            size: 20,
                          ),
                          Container(width: 20),
                          Expanded(child: Text('AVAILABLE_CREDIT'.tr)),
                          Text(currUser['freeToken'].toString())
                        ])),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: -2,
                              color: Color(0xFF4D97D3)),
                        ]),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/preference');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color:
                                          Color.fromARGB(255, 198, 222, 243))),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    KainoIcon.user,
                                    color: Color(0xFF4D97D3),
                                    size: 23,
                                  ),
                                  Container(width: 20),
                                  Expanded(child: Text('PREFERENCE'.tr)),
                                  const Icon(Icons.chevron_right)
                                ]),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    KainoIcon.twoFA,
                                    color: Color(0xFF4D97D3),
                                    size: 23,
                                  ),
                                  Container(width: 20),
                                  Expanded(child: Text('TWOFA'.tr)),
                                  const Icon(Icons.chevron_right)
                                ])),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('HISTORY'.tr),
                    Row(
                      children: [
                        Text('MORE'.tr),
                        const Icon(Icons.chevron_right)
                      ],
                    )
                  ],
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/bin.png',
                      height: 130,
                    ),
                    Container(
                      height: 10,
                    ),
                    const Text(
                      'No data',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
