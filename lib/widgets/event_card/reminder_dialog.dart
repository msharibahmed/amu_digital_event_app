import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locally/locally.dart';

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
      title: const Text('Set Reminder'),
      scrollable: true,
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Align(
                alignment: Alignment.topLeft,
                child: const Text('Select Date',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text(DateFormat('dd MMM, yyyy').format(reminderDate)),
                IconButton(
                    icon: const Icon(Icons.event),
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
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
                alignment: Alignment.topLeft,
                child: const Text('Select Time',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600))),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Row(
              children: [
                Text(reminderTime.format(context)),
                IconButton(
                    icon: const Icon(Icons.watch_rounded),
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
                child: const Text('Cancel',
                    style: const TextStyle(color: Colors.red, fontSize: 18)),
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
              child: const Text('Add Reminder',
                  style: const TextStyle(color: Colors.blue, fontSize: 18)),
            ),
          ],
        )
      ],
    );
  }
}
