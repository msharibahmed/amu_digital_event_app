import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ManageNotifications extends StatefulWidget {
  static const routeName = 'manage_notification_screen';
  @override
  _ManageNotificationsState createState() => _ManageNotificationsState();
}

class _ManageNotificationsState extends State<ManageNotifications> {
  FlutterLocalNotificationsPlugin fl = FlutterLocalNotificationsPlugin();
  List<PendingNotificationRequest> activeNotifications = [];
  var _loading = true;
// var _didBool = true;
//   @override
//   void didChangeDependencies() async {
//     super.didChangeDependencies();
//     if (_didBool) {
//       await getActiveNotification();
//     }
//     _didBool = false;
//   }
  @override
  void initState() {
    super.initState();
    getActiveNotification();
  }

  Future<void> getActiveNotification() async {
    activeNotifications = await fl.pendingNotificationRequests();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: activeNotifications.length == 0
          ? null
          : FloatingActionButton.extended(
              label: Text('Clear all reminders'),
              onPressed: () async {
                await fl.cancelAll();
                setState(() {
                  activeNotifications.clear();
                });
              },
            ),
      appBar: AppBar(
        title: Text('Manage Notifications'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: activeNotifications.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.bell_slash_fill),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('No notifications to turn off.')
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: activeNotifications.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 3,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text('${index + 1}. ' +
                                  activeNotifications[index].title),
                              subtitle: Text('Date & Time: ' +
                                  activeNotifications[index].body),
                              trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    await fl
                                        .cancel(activeNotifications[index].id);
                                    setState(() {
                                      activeNotifications.removeWhere(
                                          (notify) =>
                                              notify.id ==
                                              activeNotifications[index].id);
                                    });
                                  }),
                            ),
                          ))),
    );
  }
}
