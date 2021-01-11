import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locally/locally.dart';

import '../models/event_model.dart';

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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
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
                  child: SizedBox(
                    width: 4,
                    height: 90,
                  ),
                ),
                SizedBox(
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 4.0, top: 4, bottom: 2),
                      child: Text(
                        widget.data[widget.index].name,
                        style: TextStyle(
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
                          style: TextStyle(
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
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey))),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ReminderDialog(
                              reminderMessage: widget.data[widget.index].name,
                              // lastDate: widget.data[widget.index].endDate,
                              lastDate: DateTime.now(),
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

class ReminderDialog extends StatefulWidget {
  final DateTime lastDate;
  final String reminderTiltle;
  final String reminderMessage;
  ReminderDialog(
      {@required this.lastDate,
      @required this.reminderTiltle,
      @required this.reminderMessage});

  @override
  _ReminderDialogState createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  var reminderDate = DateTime.now().subtract(
      Duration(hours: TimeOfDay.now().hour, minutes: TimeOfDay.now().minute));
  var reminderTime = TimeOfDay.now();
  showNotification(int reminderDuration) {
    var message = widget.reminderMessage +
        '\n' +
        '@' +
        DateFormat('hh:mm aaa').format(widget.lastDate) +
        DateFormat(' dd MMM, yyyy').format(widget.lastDate);
    Locally locally;

    locally = Locally(
      pageRoute: null,
      context: context,
      payload: 'test',
      appIcon: 'amulogo',
    );
    locally.schedule(
        title: widget.reminderTiltle,
        message: message,
        duration: Duration(seconds: reminderDuration));
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Reminder'),
      scrollable: true,
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Select Date',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text(DateFormat('dd MMM, yyyy').format(reminderDate)),
                IconButton(
                    icon: Icon(Icons.event),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              // firstDate: widget.lastDate,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.parse('2021-01-24 12:00:00.000Z'))
                          .then((chosenDate) {
                        setState(() {
                          reminderDate = chosenDate;
                          // print(reminderDate);
                        });
                      });
                    }),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Select Time',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
            ),
            child: Row(
              children: [
                Text(reminderTime.format(context)),
                IconButton(
                    icon: Icon(Icons.watch_rounded),
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((chosenTime) {
                        setState(() {
                          reminderTime = chosenTime ?? TimeOfDay.now();
                          // print(reminderTime);
                        });
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
                child: Text('Cancel',
                    style: TextStyle(color: Colors.red, fontSize: 18)),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
              onPressed: () {
                int reminderDuration = DateTime.now()
                    .difference(reminderDate.add(Duration(
                        hours: reminderTime.hour,
                        minutes: reminderTime.minute)))
                    .inSeconds;
                showNotification(reminderDuration < 0
                    ? reminderDuration * (-1)
                    : reminderDuration);
                print(reminderDuration);
                Navigator.pop(context);
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text('Reminder Added'),
                //   duration: Duration(seconds: 2),
                // ));
              },
              child: Text('Add Reminder',
                  style: TextStyle(color: Colors.blue, fontSize: 18)),
            ),
          ],
        )
      ],
    );
  }
}
