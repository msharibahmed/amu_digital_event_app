import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/https.dart';
import '../widgets/notice_card.dart';

class Notices extends StatelessWidget {
  static const routeName = 'notice-screen';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final data = Provider.of<Https>(context, listen: false).noticeList;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: mq.height * 0.1,
            child: Padding(
                padding: const EdgeInsets.only(left: 35, top: 30),
                child: const Text(
                  'Notices',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 35, letterSpacing: 2),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: mq.height * 0.826,
                        ),
                        child:data.length == 0
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                Icon(Icons.notifications),
                                Text('Nothing to show!')
                              ]))
                            : ListView.builder(
                          itemBuilder: (context, index) =>
                              NoticeCard(index: index),
                          itemCount: data.length,
                        ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
