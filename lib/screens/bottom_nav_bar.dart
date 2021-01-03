import 'package:amui_digital_event_app/screens/holidays.dart';
import 'package:amui_digital_event_app/screens/settings.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'notices.dart';
import 'settings.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = 'bottom-nav-bar-screen';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var screens = {0: Home(), 1: Holidays(), 2: Notices(), 3: Settings()};
  var body = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.indigo[900],
        bottomNavigationBar: SizedBox(
          height: 53,
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
                  icon: Image.asset(
                    'assets/icons/events.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
                  ),
                  label: 'Events'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/holiday.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
                  ),
                  label: 'Holidays'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/notice.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
                  ),
                  label: 'Notices'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/settings.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
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
