import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/https.dart';
import '../widgets/holiday_card.dart';

class Exams extends StatelessWidget {
  static const routeName = 'notice-screen';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final data = Provider.of<Https>(context).holidayList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Container(
         height: mq.height*0.1,
         child:  Padding(
            padding: const EdgeInsets.only(left:35,top: 30),
            child: Text(
              'Exams',
              style: TextStyle(color: Colors.white,fontSize: 35,letterSpacing: 2),
            )),),
        ClipRRect(
          borderRadius: BorderRadius.only(
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
                        maxHeight: mq.height*0.826,
                       ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              HolidayCard(index: index),
                          itemCount: data.length,
                        )),
                  )
                ],
              )),
        )
      ],
    );
  }
}
