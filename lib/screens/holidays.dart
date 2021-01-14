import 'package:amui_digital_event_app/providers/https.dart';
import 'package:amui_digital_event_app/widgets/holiday_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Holidays extends StatelessWidget {
  static const routeName = 'holiday-screen';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final data = Provider.of<Https>(context,listen: false).holidayList;
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Container(
         height: mq.height*0.1,
         child:  Padding(
            padding: const EdgeInsets.only(left:35,top: 30,bottom: 0),
            child:const Text(
              'Holidays',
              style:const TextStyle(color: Colors.white,fontSize: 35,letterSpacing: 2),
            )),),
            SizedBox(height: 10,),
        ClipRRect(
          borderRadius:const BorderRadius.only(
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
                    child: ListView.builder(
                          itemBuilder: (context, index) =>
                              HolidayCard(index: index),
                          itemCount: data.length,
                        )
                  )
                ],
              )),
        )
      ],
    ),);
  }
}
