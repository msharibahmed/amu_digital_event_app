import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/https.dart';
import '../widgets/entrance_card.dart';

class Entrances extends StatelessWidget {
  static const routeName = 'entrance-screen';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final data = Provider.of<Https>(context, listen: false).entranceList;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Filter Entraces'),
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
                      'Entrances',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 35, letterSpacing: 2),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(40),
                    topRight: const Radius.circular(40)),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 10),
                              child: const Text(
                                'Sorted By: ' + 'Name',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            )),
                        ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: mq.height * 0.786,
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: EntranceCard(index: index),
                              ),
                              itemCount: data.length,
                            ))
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
