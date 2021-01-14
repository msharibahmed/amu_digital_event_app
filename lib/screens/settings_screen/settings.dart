import 'package:amui_digital_event_app/screens/settings_screen/help.dart';
import 'package:amui_digital_event_app/screens/settings_screen/manage_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const routeName = 'settings-screen';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[400],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 33, vertical: 15),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            letterSpacing: 1),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                          color: Colors.white,
                          height: mq.height * 0.8025,
                          child: ListView(
                            children: [
                              settingsCard(
                                  Icons.notifications,
                                  'Manage Notifications',
                                  'Reminders & notifications',
                                  () {Navigator.pushNamed(
                                    context, ManageNotifications.routeName);}),
                              settingsCard(
                                  Icons.wb_sunny, 'Theme', 'Change theme', () {
                                showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          title: Text('choose Theme'),
                                          // content: Column(children: [RadioListTile()],,
                                        ));
                              }),
                              settingsCard(Icons.help_center, 'Help',
                                  'Contact us & privacy policy', () {
                                // print('help');
                                Navigator.pushNamed(
                                    context, HelpScreen.routeName);
                              }),
                              settingsCard(Icons.developer_board, 'Developers',
                                  'About developers', () {})
                            ],
                          )),
                    )
                  ],
                ))),
      ),
    );
  }

  Widget settingsCard(
      IconData icon, String title, String subtitle, Function func) {
    return GestureDetector(
      onTap: func,
      child: Card(
        elevation: 5,
        shadowColor: Colors.indigo,
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                icon,
                color: Colors.black,
              ),
              title: Text(
                title,
                style: const TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
