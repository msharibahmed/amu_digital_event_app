import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/event_model.dart';
import 'reminder_dialog.dart';

class EventCard extends StatefulWidget {
  final int index;
  final List<EventModel> data;
  EventCard({@required this.index, @required this.data});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  color: widget.data[0].startDate.isAfter(DateTime.now())
                      ? Colors.green
                      : widget.data[0].endDate.isBefore(DateTime.now())
                          ? Colors.red
                          : Colors.indigo,
                  child: const SizedBox(
                    width: 4,
                    height: 90,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 4.0, top: 4, bottom: 2),
                      child: Text(
                        DateFormat('dd MMM')
                                .format(widget.data[widget.index].startDate) +
                            '-' +
                            DateFormat('dd MMM')
                                .format(widget.data[widget.index].endDate),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 4.0, top: 4, bottom: 2),
                      child: Text(
                        widget.data[widget.index].name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 4.0, top: 4, bottom: 2),
                      child: Text(
                          'Time: ' +
                              DateFormat('hh:mm aaa')
                                  .format(widget.data[widget.index].startDate) +
                              '-' +
                              DateFormat('hh:mm aaa')
                                  .format(widget.data[widget.index].endDate),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey)),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 4.0, top: 4, bottom: 4),
                        child: Text(
                            'Mode: ' +
                                (widget.data[widget.index].online
                                    ? 'Online'
                                    : 'Offline'),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey))),
                  ],
                ),
                const Spacer(),
                if (!widget.data[0].endDate.isBefore(DateTime.now()))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              
                              return ReminderDialog(
                                reminderMessage: widget.data[widget.index].name,
                                lastDate: widget.data[widget.index].endDate,
                                startDate: DateTime.now(),
                                reminderTiltle: 'Event Reminder',
                              );
                            });
                      },
                      child: Image.asset(
                        'assets/icons/' + 'add_reminder.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
