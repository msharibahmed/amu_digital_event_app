import 'package:amui_digital_event_app/providers/https.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'bottomsheet_event_card.dart';
import 'bottomsheet_holidays_card.dart';

class EventBottomSheet extends StatelessWidget {
  final DateTime selectedDate;
  EventBottomSheet({@required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    // print(selectedDate);
    final prov = Provider.of<Https>(context, listen: false);
    print(prov.selectedDayEvents(selectedDate));
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selected Day\'s Details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.values[1],
              children: [
                Text(
                  DateFormat('dd').format(selectedDate),
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[900]),
                ),
                Text(
                  DateFormat('MMMM').format(selectedDate),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey[700]),
                ),
                Text(', '),
                Text(
                  DateFormat('yyyy').format(selectedDate),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey[700]),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Events' +
                  '(' +
                  prov.selectedDayEvents(selectedDate).length.toString() +
                  ')',
              style: TextStyle(
                  letterSpacing: 1, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
              color: Colors.grey[200],
              width: double.infinity,
              height: 120,
              child: prov.selectedDayEvents(selectedDate).length == 0
                  ? Center(
                      child: Text('No Events!'),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BottomSheetEventCard(
                          index: index, selectedDate: selectedDate),
                      itemCount: prov.selectedDayEvents(selectedDate).length,
                    )),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Holidays' +
                    '(' +
                    prov.selectedDayHoliday(selectedDate).length.toString() +
                    ')',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
          ),
          Container(
              color: Colors.grey[200],
              width: double.infinity,
              height: 120,
              child: prov.selectedDayHoliday(selectedDate).length == 0
                  ? Center(
                      child: Text('No Holidays!'),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BottomSheetHolidayCard(
                          index: index, selectedDate: selectedDate),
                      itemCount: prov.selectedDayHoliday(selectedDate).length,
                    )),
        ],
      ),
    );
  }
}
