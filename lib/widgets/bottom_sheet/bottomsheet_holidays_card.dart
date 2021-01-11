import 'package:amui_digital_event_app/providers/https.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BottomSheetHolidayCard extends StatelessWidget {
  final int index;
  final DateTime selectedDate;
  BottomSheetHolidayCard({@required this.index, @required this.selectedDate});
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Https>(context,listen: false).selectedDayHoliday(selectedDate);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
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
                color: Colors.red,
                child: SizedBox(
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
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
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 0, bottom: 2),
                child: Text('From: ' + DateFormat('dd-MM-yyy').format(prov[index].startDate),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey)),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 4, bottom: 0),
                child: Text('To: ' + DateFormat('dd-MM-yyy').format(prov[index].endDate),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey)),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
