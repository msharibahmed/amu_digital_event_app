import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:locally/locally.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReminderDialog extends StatefulWidget {
  final DateTime lastDate;
  final DateTime startDate;
  final String reminderTiltle;
  final String reminderMessage;
  ReminderDialog(
      {@required this.lastDate,
      @required this.startDate,
      @required this.reminderTiltle,
      @required this.reminderMessage});

  @override
  _ReminderDialogState createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  FlutterLocalNotificationsPlugin fl = FlutterLocalNotificationsPlugin();

  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('amulogo');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    fl.initialize(initSetttings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    return null;
  }

  showNotificationn(int id, DateTime scheduleDate) async {
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        icon: 'events_filled',
        color: Colors.green,
        category: 'event',
        largeIcon: DrawableResourceAndroidBitmap('amulogo'),
        priority: Priority.High,
        importance: Importance.Max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await fl.schedule(
        id,
        widget.reminderTiltle + ':  ' + widget.reminderMessage,
        DateFormat('dd MMM @hh:mm aaa-').format(widget.startDate) +
            DateFormat('dd MMM @hh:mm aaa').format(widget.lastDate),
        scheduleDate,
        platform);
  }

  var reminderDate = DateTime.now().subtract(
      Duration(hours: TimeOfDay.now().hour, minutes: TimeOfDay.now().minute));
  var reminderTime = TimeOfDay.now();

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
                    icon: const Icon(CupertinoIcons.calendar, size: 30),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: widget.lastDate)
                          .then((chosenDate) {
                        setState(() {
                          reminderDate = chosenDate ??
                              DateTime.now().subtract(Duration(
                                  hours: TimeOfDay.now().hour,
                                  minutes: TimeOfDay.now().minute));
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
                    icon: const Icon(CupertinoIcons.time, size: 30),
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
                DateTime reminderDuration = reminderDate.add(Duration(
                    hours: reminderTime.hour, minutes: reminderTime.minute));
                var d = DateTime.now();
                var randomInteger =
                    d.day + d.month + d.year + d.hour + d.minute + d.second;
                showNotificationn(randomInteger, reminderDuration);
                // print(reminderDuration);
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
