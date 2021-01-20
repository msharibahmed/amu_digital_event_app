import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/https.dart';
import '../widgets/exams_card.dart';

class Exams extends StatelessWidget {
  static const routeName = 'exam-screen';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final data = Provider.of<Https>(context, listen: false).examList;
    return Scaffold(
      floatingActionButton: data.length == 0
          ? null
          : FloatingActionButton.extended(
              label: const Text('Filter Exams'),
              icon: const Icon(Icons.sort),
              onPressed: () {},
            ),
      backgroundColor: Colors.indigo[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: mq.height * 0.1,
              child: Padding(
                  padding: const EdgeInsets.only(left: 35, top: 30),
                  child: const Text(
                    'Exams',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 35, letterSpacing: 2),
                  )),
            ),
            const SizedBox(
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
                      if (data.length != 0)
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 10),
                              child: Text(
                                'Sorted By: ' + 'Faculty',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            )),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: data.length == 0
                                ? mq.height * 0.82
                                : mq.height * 0.786,
                          ),
                          child:data.length == 0
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                Image.asset(
                                    'assets/icons/exam_loading.png',
                                    fit: BoxFit.fill,
                                  ),
                                Text('Nothing to show!')
                              ]))
                            :
                            ListView.builder(
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ExamsCard(index: index),
                                  ),
                                  itemCount: data.length,
                                ))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
