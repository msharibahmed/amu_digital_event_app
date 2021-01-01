import 'package:amui_digital_event_app/screens/holidays.dart';
import 'package:amui_digital_event_app/screens/settings.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'notices.dart';
import 'events.dart';
import 'settings.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = 'bottom-nav-bar-screen';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var screens = {
    0: Home(),
    1: Events(),
    2: Holidays(),
    3: Notices(),
    4: Settings()
  };
  var body = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,

        backgroundColor: Colors.indigo[900],
        //   title: Text('AMU Digital Event'),
        // ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                body = index;
              });
            },
            currentIndex: body,
            iconSize: 20,
            selectedFontSize: 15,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,

            
            unselectedFontSize: 15,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.event,
                    color: Colors.black,
                  ),
                  label: 'Events'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.ac_unit,
                    color: Colors.black,
                  ),
                  label: 'Holidays'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.flight_takeoff_sharp,
                    color: Colors.black,
                  ),
                  label: 'Notices'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  label: 'Setting'),
            ],
          ),
        ),
        body: screens[body],
      ),
    );
  }
}
