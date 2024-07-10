import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kaino/network/api.dart';

class RenderHistory extends StatefulWidget {
  const RenderHistory({super.key});

  @override
  State<RenderHistory> createState() => _RenderHistoryState();
}

class _RenderHistoryState extends State<RenderHistory> {
  List data = [];
  @override
  void initState() {
    super.initState();

    imgHistory({'page': 1, 'pageSize': 999}).then((res) {
      dynamic initData = {
        'today': [],
        'yesterday': [],
        'sevenDay': [],
        'oneMonth': [],
        'older': []
      };
      int oneDay = 86400000;
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      int today = startOfDay.millisecondsSinceEpoch;
      int yesterday = today - oneDay;
      int seventhDay = today - oneDay * 6;
      int oneMonth = today - oneDay * 29;

      for (var item in res['data']) {
        int currentDay =
            DateTime.parse(item['createDateTime']).millisecondsSinceEpoch;
        if (today <= currentDay) {
          initData['today'].add(item);
        } else if (yesterday <= currentDay) {
          initData['yesterday'].add(item);
        } else if (seventhDay <= currentDay) {
          initData['sevenDay'].add(item);
        } else if (oneMonth <= currentDay) {
          initData['oneMonth'].add(item);
        } else {
          initData['older'].add(item);
        }
      }
      List newData = [];
      if (initData['today'].isNotEmpty) {
        newData = [
          ...newData,
          {'id': -1, 'text': 'TODAY'.tr},
          ...initData['today'],
        ];
      }
      if (initData['yesterday'].isNotEmpty) {
        newData = [
          ...newData,
          {'id': -2, 'text': 'YESTERDAY'.tr},
          ...initData['yesterday'],
        ];
      }
      if (initData['sevenDay'].isNotEmpty) {
        newData = [
          ...newData,
          {'id': -3, 'text': 'PREVIOUS_7_DAYS'.tr},
          ...initData['sevenDay'],
        ];
      }
      if (initData['oneMonth'].isNotEmpty) {
        newData = [
          ...newData,
          {'id': -4, 'text': 'PREVIOUS_30_DAYS'.tr},
          ...initData['oneMonth'],
        ];
      }
      if (initData['older'].isNotEmpty) {
        newData = [
          ...newData,
          {'id': -5, 'text': 'EARLIER'.tr},
          ...initData['older'],
        ];
      }
      setState(() {
        data = newData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = data.map((e) {
      if (e['id'] < 0) {
        return Text(
          e['text'],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/renderDetail', arguments: e);
          },
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy-MM-dd  HH:mm:ss')
                      .format(DateTime.parse(e['createDateTime'])),
                  style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF808080),
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Visibility(
                        child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: const Color(0xFF808080)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        e['renderParameter']['room'],
                        style: const TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 92, 92, 92)),
                      ),
                    )),
                    Visibility(
                        child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Color(0xFF808080)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        e['renderParameter']['style'].contains(',')
                            ? e['renderParameter']['style'].split(',')[0]
                            : e['renderParameter']['style'],
                        style: const TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 92, 92, 92)),
                      ),
                    )),
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(e['cover'],
                  height: 250, width: double.infinity, fit: BoxFit.cover),
            )
          ]),
        );
      }
    }).toList();

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: Text(
            'RenderHistory'.tr,
            style: const TextStyle(color: Color(0xFF4D97D3), fontSize: 18),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Expanded(
              child: dataList.isEmpty
                  ? Column(
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
                    )
                  : ListView(
                      children: dataList.isEmpty ? [] : dataList,
                    )),
        ));
  }
}
