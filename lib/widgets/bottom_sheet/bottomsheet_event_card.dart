import 'package:amui_digital_event_app/providers/https.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BottomSheetEventCard extends StatelessWidget {
  final int index;
  final DateTime selectedDate;
  BottomSheetEventCard({@required this.index, @required this.selectedDate});
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Https>(context,listen: false).selectedDayEvents(selectedDate);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius:const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Container(
          width: 222,
          decoration: BoxDecoration(
            color: Colors.white,
            // boxShadow: [BoxShadow(spreadRadius: 5,blurRadius: 5,offset: Offset.infinite,color: Colors.amber)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 3,
                color: Colors.green,
                child:const SizedBox(
                  width: 222,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Text(
                        prov[index].name,
                        overflow: TextOverflow.fade,
                        style:const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/' + 'add_reminder.png',
                      width: 18,
                      height: 18,
                    ),
                  )
                ],
              ),
            const  SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 0, bottom: 2),
                child: Text('Time: ' +
                              DateFormat('hh:mm aaa')
                                  .format(prov[index].startDate) +
                              '-' +
                              DateFormat('hh:mm aaa')
                                  .format(prov[index].endDate),
                    style:const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 4, bottom: 0),
                child: Text('Mode: ' + (prov[index].online?'Online':'Offline'),
                    style:const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
